#include <stdlib.h>
#include <string.h>

char* convertToBase7(int num) {
    if (num == 0) {
        char* result = (char*)malloc(sizeof(char) * 2);
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    char buffer[15]; 
    int i = 0;
    int sign = 1;

    if (num < 0) {
        sign = -1;
        num = -num; 
    }

    while (num > 0) {
        buffer[i++] = (num % 7) + '0';
        num /= 7;
    }

    if (sign == -1) {
        buffer[i++] = '-';
    }

    int start = 0;
    int end = i - 1;
    while (start < end) {
        char temp = buffer[start];
        buffer[start] = buffer[end];
        buffer[end] = temp;
        start++;
        end--;
    }
    buffer[i] = '\0';

    char* result = (char*)malloc(sizeof(char) * (i + 1));
    strcpy(result, buffer);

    return result;
}
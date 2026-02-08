#include <stdlib.h>

char *convertToTitle(int columnNumber) {
    char *result = (char *)malloc(sizeof(char) * 10);
    int i = 0;

    while (columnNumber > 0) {
        columnNumber--;
        result[i++] = 'A' + (columnNumber % 26);
        columnNumber /= 26;
    }
    result[i] = '\0';

    int start = 0;
    int end = i - 1;
    while (start < end) {
        char temp = result[start];
        result[start] = result[end];
        result[end] = temp;
        start++;
        end--;
    }

    return result;
}
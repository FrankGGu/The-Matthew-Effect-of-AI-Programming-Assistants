#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * convertToTitle(int columnNumber){
    char *result = (char *)malloc(10 * sizeof(char));
    int i = 0;
    while (columnNumber > 0) {
        columnNumber--;
        result[i++] = 'A' + (columnNumber % 26);
        columnNumber /= 26;
    }
    result[i] = '\0';

    int left = 0;
    int right = i - 1;
    while (left < right) {
        char temp = result[left];
        result[left] = result[right];
        result[right] = temp;
        left++;
        right--;
    }

    return result;
}
#include <string.h>
#include <stdlib.h>

char* largestOddNumber(char* num) {
    int n = strlen(num);
    for (int i = n - 1; i >= 0; i--) {
        if ((num[i] - '0') % 2 != 0) {
            char* result = (char*)malloc(sizeof(char) * (i + 2));
            strncpy(result, num, i + 1);
            result[i + 1] = '\0';
            return result;
        }
    }
    char* empty_string = (char*)malloc(sizeof(char));
    empty_string[0] = '\0';
    return empty_string;
}
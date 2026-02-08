#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* reformatNumber(char* phone) {
    int len = strlen(phone);
    char* result = (char*)malloc((len + 4) * sizeof(char));
    int i = 0, j = 0;

    while (i < len) {
        if (j > 0 && j % 3 == 0) {
            result[j++] = '-';
        }
        result[j++] = phone[i++];
    }

    result[j] = '\0';
    return result;
}
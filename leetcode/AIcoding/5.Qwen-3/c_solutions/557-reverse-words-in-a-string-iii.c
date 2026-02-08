#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* reverseWords(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int i = 0, j = 0;

    while (i < len) {
        while (i < len && s[i] == ' ') i++;
        j = i;
        while (j < len && s[j] != ' ') j++;
        int k = j - 1;
        while (k >= i) {
            result[i++] = s[k--];
        }
        if (i < len) {
            result[i++] = ' ';
        }
        i = j;
    }
    result[i] = '\0';
    return result;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* backspaceCompare(char* s, char* t) {
    int len_s = strlen(s);
    int len_t = strlen(t);
    char* result = (char*)malloc(2 * sizeof(char));
    int i = len_s - 1, j = len_t - 1;
    int skip_s = 0, skip_t = 0;

    while (i >= 0 || j >= 0) {
        while (i >= 0) {
            if (s[i] == '#') {
                skip_s++;
                i--;
            } else if (skip_s > 0) {
                skip_s--;
                i--;
            } else {
                break;
            }
        }

        while (j >= 0) {
            if (t[j] == '#') {
                skip_t++;
                j--;
            } else if (skip_t > 0) {
                skip_t--;
                j--;
            } else {
                break;
            }
        }

        if (i >= 0 && j >= 0) {
            if (s[i] != t[j]) {
                strcpy(result, "false");
                return result;
            }
        } else if ((i >= 0) != (j >= 0)) {
            strcpy(result, "false");
            return result;
        }

        i--;
        j--;
    }

    strcpy(result, "true");
    return result;
}
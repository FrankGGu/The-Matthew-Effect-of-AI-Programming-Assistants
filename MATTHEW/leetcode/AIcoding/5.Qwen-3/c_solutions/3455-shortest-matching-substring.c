#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* shortestSubstr(char* s, char* t) {
    int len_s = strlen(s);
    int len_t = strlen(t);
    char* result = (char*)malloc(sizeof(char) * (len_t + 1));
    int min_len = len_t + 1;
    int found = 0;

    for (int i = 0; i < len_s; i++) {
        if (s[i] == t[0]) {
            int j = 0;
            int k = i;
            while (j < len_t && k < len_s) {
                if (s[k] == t[j]) {
                    j++;
                }
                k++;
            }
            if (j == len_t) {
                int current_len = k - i;
                if (current_len < min_len) {
                    min_len = current_len;
                    found = 1;
                    strncpy(result, s + i, min_len);
                    result[min_len] = '\0';
                }
            }
        }
    }

    if (!found) {
        return "";
    } else {
        return result;
    }
}
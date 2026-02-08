#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxUniqueSplit(char *s) {
    int n = strlen(s);
    int max = 0;
    char* substrings[n];
    int count = 0;

    void backtrack(int start) {
        if (start == n) {
            if (count > max) {
                max = count;
            }
            return;
        }

        for (int i = start; i < n; i++) {
            int len = i - start + 1;
            char substring[len + 1];
            strncpy(substring, s + start, len);
            substring[len] = '\0';

            bool unique = true;
            for (int j = 0; j < count; j++) {
                if (strcmp(substring, substrings[j]) == 0) {
                    unique = false;
                    break;
                }
            }

            if (unique) {
                substrings[count] = strdup(substring);
                count++;
                backtrack(i + 1);
                free(substrings[count - 1]);
                count--;
            }
        }
    }

    backtrack(0);
    return max;
}
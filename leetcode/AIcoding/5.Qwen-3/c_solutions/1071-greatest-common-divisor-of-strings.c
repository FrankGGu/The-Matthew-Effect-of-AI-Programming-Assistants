#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* gcdOfStrings(char* s1, char* s2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    int minLen = (len1 < len2) ? len1 : len2;

    for (int i = minLen; i >= 1; i--) {
        if (len1 % i == 0 && len2 % i == 0) {
            char* candidate = (char*)malloc((i + 1) * sizeof(char));
            strncpy(candidate, s1, i);
            candidate[i] = '\0';

            int valid = 1;
            for (int j = 0; j < len1; j += i) {
                if (strncmp(s1 + j, candidate, i) != 0) {
                    valid = 0;
                    break;
                }
            }
            for (int j = 0; j < len2; j += i) {
                if (strncmp(s2 + j, candidate, i) != 0) {
                    valid = 0;
                    break;
                }
            }

            if (valid) {
                return candidate;
            }
        }
    }

    return "";
}
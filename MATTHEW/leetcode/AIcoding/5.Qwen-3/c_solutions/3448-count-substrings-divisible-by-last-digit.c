#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char* s) {
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j <= n; j++) {
            char sub[j - i];
            strncpy(sub, s + i, j - i);
            sub[j - i] = '\0';
            int lastDigit = sub[strlen(sub) - 1] - '0';
            if (lastDigit != 0) {
                int num = atoi(sub);
                if (num % lastDigit == 0) {
                    count++;
                }
            }
        }
    }
    return count;
}
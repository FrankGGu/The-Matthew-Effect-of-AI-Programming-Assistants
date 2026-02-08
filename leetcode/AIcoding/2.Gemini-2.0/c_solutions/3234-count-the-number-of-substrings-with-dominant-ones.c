#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char* s) {
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int ones = 0;
            int zeros = 0;
            for (int k = i; k <= j; k++) {
                if (s[k] == '1') {
                    ones++;
                } else {
                    zeros++;
                }
            }
            if (ones > zeros) {
                count++;
            }
        }
    }

    return count;
}
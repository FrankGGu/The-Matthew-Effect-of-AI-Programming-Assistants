#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char *s, int k) {
    int n = strlen(s);
    int count = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int vowelCount[5] = {0};
            int consonantCount = 0;
            bool hasA = false, hasE = false, hasI = false, hasO = false, hasU = false;

            for (int l = i; l <= j; l++) {
                if (s[l] == 'a') {
                    hasA = true;
                } else if (s[l] == 'e') {
                    hasE = true;
                } else if (s[l] == 'i') {
                    hasI = true;
                } else if (s[l] == 'o') {
                    hasO = true;
                } else if (s[l] == 'u') {
                    hasU = true;
                } else {
                    consonantCount++;
                }
            }

            if (hasA && hasE && hasI && hasO && hasU && consonantCount == k) {
                count++;
            }
        }
    }

    return count;
}
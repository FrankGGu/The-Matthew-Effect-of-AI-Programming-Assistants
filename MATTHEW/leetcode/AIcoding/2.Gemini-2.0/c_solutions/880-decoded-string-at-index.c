#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char decodeAtIndex(char *s, int k) {
    long long n = strlen(s);
    long long decodedLength = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] >= 'a' && s[i] <= 'z') {
            decodedLength++;
        } else {
            int digit = s[i] - '0';
            decodedLength *= digit;
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        k %= decodedLength;
        if (k == 0 && (s[i] >= 'a' && s[i] <= 'z')) {
            return s[i];
        }

        if (s[i] >= 'a' && s[i] <= 'z') {
            decodedLength--;
        } else {
            int digit = s[i] - '0';
            decodedLength /= digit;
        }
    }

    return ' ';
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkEquality(char *s, int index1, int index2) {
    return s[index1] == s[index2];
}

bool areDigitsEqual(char *s) {
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }

    if (n <= 1) {
        return true;
    }

    for (int i = 0; i < n; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            for (int j = i + 1; j < n; j++) {
                if (s[j] >= '0' && s[j] <= '9') {
                    if (!checkEquality(s, i, j)) {
                        return false;
                    }
                }
            }
        }
    }

    return true;
}
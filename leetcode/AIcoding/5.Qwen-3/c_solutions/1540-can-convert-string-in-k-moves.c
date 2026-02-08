#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canConvertString(char *s, char *t, int k) {
    if (strlen(s) != strlen(t)) return false;

    int count[26] = {0};
    for (int i = 0; i < strlen(s); i++) {
        if (s[i] != t[i]) {
            int diff = (t[i] - s[i] + 26) % 26;
            count[diff]++;
        }
    }

    for (int i = 1; i <= 25; i++) {
        if (count[i] > 0) {
            int maxMove = (count[i] - 1) * 26 + i;
            if (maxMove > k) return false;
        }
    }

    return true;
}
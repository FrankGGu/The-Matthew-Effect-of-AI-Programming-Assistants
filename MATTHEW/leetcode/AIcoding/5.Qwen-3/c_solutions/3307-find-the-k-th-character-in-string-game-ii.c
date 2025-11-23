#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char findKthCharacter(char* s, int k) {
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] == 'A') {
            continue;
        }
        int len = 1;
        for (int j = i + 1; j < n && s[j] != 'A'; j++) {
            len *= 2;
        }
        if (k <= len) {
            return s[i];
        }
        k -= len;
    }
    return s[0];
}
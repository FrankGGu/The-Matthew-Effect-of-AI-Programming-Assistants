#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canConvertString(char * s, char * t, int k) {
    int n = strlen(s);
    int m = strlen(t);
    if (n != m) return false;

    int diff[26];
    for (int i = 0; i < 26; i++) diff[i] = 0;

    for (int i = 0; i < n; i++) {
        int d = (t[i] - s[i] + 26) % 26;
        if (d != 0) {
            diff[d]++;
        }
    }

    for (int i = 1; i < 26; i++) {
        if ((long long)(i + 26LL * (long long)(diff[i] - 1)) > (long long)k) {
            return false;
        }
    }

    return true;
}
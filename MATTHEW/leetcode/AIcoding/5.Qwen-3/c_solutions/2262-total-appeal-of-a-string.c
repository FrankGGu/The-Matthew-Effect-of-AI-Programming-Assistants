#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int totalAuction(string s) {
    int n = strlen(s);
    int result = 0;
    int last[26] = {0};

    for (int i = 0; i < n; i++) {
        int c = s[i] - 'a';
        if (last[c] > 0) {
            result += (i - last[c] + 1);
        } else {
            result += (i + 1);
        }
        last[c] = i + 1;
    }

    return result;
}
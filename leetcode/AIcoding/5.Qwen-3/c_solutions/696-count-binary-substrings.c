#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countBinarySubstrings(char *s) {
    int n = strlen(s);
    int prev = 0, curr = 1, count = 0;
    for (int i = 1; i < n; i++) {
        if (s[i] == s[i - 1]) {
            curr++;
        } else {
            count += prev < curr ? prev : curr;
            prev = curr;
            curr = 1;
        }
    }
    count += prev < curr ? prev : curr;
    return count;
}
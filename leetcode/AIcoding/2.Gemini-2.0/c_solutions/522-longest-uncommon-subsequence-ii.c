#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isSubsequence(const char *s, const char *t) {
    int i = 0, j = 0;
    while (s[i] && t[j]) {
        if (s[i] == t[j]) {
            i++;
        }
        j++;
    }
    return s[i] == '\0';
}

int findLUSlength(char **strs, int strsSize) {
    int ans = -1;
    for (int i = 0; i < strsSize; i++) {
        bool valid = true;
        for (int j = 0; j < strsSize; j++) {
            if (i != j && isSubsequence(strs[i], strs[j])) {
                valid = false;
                break;
            }
        }
        if (valid) {
            int len = strlen(strs[i]);
            if (len > ans) {
                ans = len;
            }
        }
    }
    return ans;
}
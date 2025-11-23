#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define MAX_CHAR 26

int uniquePalindromicSubseq(char * s) {
    int n = strlen(s);
    bool seen[MAX_CHAR][MAX_CHAR] = {false};
    bool exists[MAX_CHAR] = {false};
    int count = 0;

    for (int i = 0; i < n; i++) {
        exists[s[i] - 'a'] = true;
    }

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (s[i] == s[j]) {
                for (int k = 0; k < MAX_CHAR; k++) {
                    if (exists[k] && k != (s[i] - 'a')) {
                        if (!seen[s[i] - 'a'][k]) {
                            count++;
                            seen[s[i] - 'a'][k] = true;
                        }
                    }
                }
            }
        }
    }

    return count;
}
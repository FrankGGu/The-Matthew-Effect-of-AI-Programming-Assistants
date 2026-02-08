#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char *s, char *t) {
    int n = strlen(s);
    int m = strlen(t);
    int count = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            int freq[26] = {0};
            for (int k = i; k <= j; k++) {
                freq[s[k] - 'a']++;
            }

            bool possible = true;
            for (int k = 0; k < m; k++) {
                if (freq[t[k] - 'a'] == 0) {
                    possible = false;
                    break;
                }
                freq[t[k] - 'a']--;
            }

            if (possible) {
                count++;
            }
        }
    }

    return count;
}
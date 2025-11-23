#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int totalCharacters(char* s) {
    int count[26] = {0};
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }
    int ans = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) {
            ans++;
        }
    }
    return ans;
}
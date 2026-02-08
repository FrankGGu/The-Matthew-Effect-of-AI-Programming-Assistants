#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canConstruct(char * s, int k){
    int n = strlen(s);
    if (k > n) return false;

    int count[26] = {0};
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    int odd_count = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] % 2 != 0) {
            odd_count++;
        }
    }

    return odd_count <= k;
}
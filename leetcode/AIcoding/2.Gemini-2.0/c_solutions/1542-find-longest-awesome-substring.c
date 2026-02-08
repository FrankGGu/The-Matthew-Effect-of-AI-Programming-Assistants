#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestAwesome(char * s){
    int n = strlen(s);
    int ans = 0;
    int mask = 0;
    int first[1024];
    memset(first, -1, sizeof(first));
    first[0] = 0;

    for (int i = 0; i < n; i++) {
        mask ^= (1 << (s[i] - '0'));

        if (first[mask] == -1) {
            first[mask] = i + 1;
        } else {
            ans = fmax(ans, i + 1 - first[mask]);
        }

        for (int j = 0; j < 10; j++) {
            int temp_mask = mask ^ (1 << j);
            if (first[temp_mask] != -1) {
                ans = fmax(ans, i + 1 - first[temp_mask]);
            }
        }
    }

    return ans;
}
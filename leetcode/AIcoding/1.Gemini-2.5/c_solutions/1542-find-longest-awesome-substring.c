#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int longestAwesome(char * s){
    int n = strlen(s);

    int pos[1 << 10]; 
    for (int i = 0; i < (1 << 10); ++i) {
        pos[i] = -1;
    }

    int current_mask = 0;
    int ans = 0;

    pos[0] = -1;

    for (int i = 0; i < n; ++i) {
        int digit = s[i] - '0';
        current_mask ^= (1 << digit);

        if (pos[current_mask] != -1) {
            ans = max(ans, i - pos[current_mask]);
        } else {
            pos[current_mask] = i;
        }

        for (int k = 0; k < 10; ++k) {
            int target_mask = current_mask ^ (1 << k);
            if (pos[target_mask] != -1) {
                ans = max(ans, i - pos[target_mask]);
            }
        }
    }

    return ans;
}
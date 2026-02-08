#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSubstring(char* s, int k) {
    int len = strlen(s);
    if (len < k) return 0;

    int count[26] = {0};
    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }

    for (int i = 0; i < len; i++) {
        if (count[s[i] - 'a'] < k) {
            char* left = s;
            char* right = s + i;
            int max = 0;
            while (left <= right) {
                if (*left == s[i]) {
                    int subLen = longestSubstring(left + 1, k);
                    if (subLen > max) max = subLen;
                }
                left++;
            }
            return max;
        }
    }

    return len;
}
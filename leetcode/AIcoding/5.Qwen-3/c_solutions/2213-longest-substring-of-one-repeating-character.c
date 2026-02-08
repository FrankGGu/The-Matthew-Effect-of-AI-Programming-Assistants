#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSubstring(string s, int k) {
    int n = strlen(s);
    int maxLen = 0;
    for (int i = 0; i < n; i++) {
        int count[26] = {0};
        int unique = 0;
        int maxCount = 0;
        for (int j = i; j < n; j++) {
            int idx = s[j] - 'a';
            if (count[idx] == 0) unique++;
            count[idx]++;
            maxCount = (count[idx] > maxCount) ? count[idx] : maxCount;
            if (unique <= k && maxCount >= k) {
                maxLen = (j - i + 1) > maxLen ? (j - i + 1) : maxLen;
            }
        }
    }
    return maxLen;
}
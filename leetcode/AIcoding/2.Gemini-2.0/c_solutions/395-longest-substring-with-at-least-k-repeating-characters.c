#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSubstring(char * s, int k){
    int len = strlen(s);
    if (len == 0 || len < k) return 0;
    if (k <= 1) return len;

    int count[26] = {0};
    for (int i = 0; i < len; i++) {
        count[s[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (count[i] > 0 && count[i] < k) {
            char c = 'a' + i;
            int maxLen = 0;
            char *start = s;
            char *end = s;
            while (end < s + len) {
                if (*end == c) {
                    int subLen = end - start;
                    int subResult = longestSubstring(start, k);
                    if (subResult > maxLen) {
                        maxLen = subResult;
                    }
                    start = end + 1;
                }
                end++;
            }

            int subLen = end - start;
            int subResult = longestSubstring(start, k);
            if (subResult > maxLen) {
                maxLen = subResult;
            }
            return maxLen;
        }
    }

    return len;
}
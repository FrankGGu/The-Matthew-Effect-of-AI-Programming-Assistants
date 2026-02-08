#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxLength(char* s) {
    int maxLen = 0;
    int count[26] = {0};
    int left = 0;
    for (int right = 0; right < strlen(s); right++) {
        count[s[right] - 'a']++;
        while (count[s[right] - 'a'] > 2) {
            count[s[left] - 'a']--;
            left++;
        }
        maxLen = (right - left + 1) > maxLen ? (right - left + 1) : maxLen;
    }
    return maxLen;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canConstructPalindrome(char* s, int k) {
    int freq[26] = {0};
    int len = strlen(s);
    if (len < k) return false;
    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }
    int oddCount = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] % 2 != 0) {
            oddCount++;
        }
    }
    return oddCount <= k;
}
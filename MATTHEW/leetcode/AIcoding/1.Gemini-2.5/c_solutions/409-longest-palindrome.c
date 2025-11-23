#include <string.h>
#include <stdbool.h>

int longestPalindrome(char * s) {
    int freq[52] = {0}; // 26 for 'a'-'z', 26 for 'A'-'Z'
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        if (s[i] >= 'a' && s[i] <= 'z') {
            freq[s[i] - 'a']++;
        } else if (s[i] >= 'A' && s[i] <= 'Z') {
            freq[s[i] - 'A' + 26]++;
        }
    }

    int palindromeLength = 0;
    bool hasOdd = false;

    for (int i = 0; i < 52; i++) {
        palindromeLength += (freq[i] / 2) * 2;
        if (freq[i] % 2 == 1) {
            hasOdd = true;
        }
    }

    if (hasOdd) {
        palindromeLength++;
    }

    return palindromeLength;
}
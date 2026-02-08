#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countOfSubstrings(char* s, int k) {
    int n = strlen(s);
    int vowels[26] = {0};
    int count = 0;
    int vowelCount = 0;
    int left = 0;
    int right = 0;

    while (right < n) {
        char c = s[right];
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
            vowels[c - 'a']++;
            if (vowels[c - 'a'] == 1) {
                vowelCount++;
            }
        }

        while (vowelCount > 5 || (right - left + 1 - vowelCount) > k) {
            char l = s[left];
            if (l == 'a' || l == 'e' || l == 'i' || l == 'o' || l == 'u') {
                vowels[l - 'a']--;
                if (vowels[l - 'a'] == 0) {
                    vowelCount--;
                }
            }
            left++;
        }

        if (vowelCount == 5 && (right - left + 1 - vowelCount) == k) {
            count++;
        }

        right++;
    }

    return count;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countOfSubstrings(char* s, int k) {
    int n = strlen(s);
    int count = 0;
    int vowels[26] = {0};
    int vowelCount = 0;
    int consonantCount = 0;
    int left = 0;

    for (int right = 0; right < n; right++) {
        char c = s[right];
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
            vowels[c - 'a']++;
            if (vowels[c - 'a'] == 1) {
                vowelCount++;
            }
        } else {
            consonantCount++;
        }

        while (vowelCount == 5 && consonantCount > k) {
            char leftChar = s[left];
            if (leftChar == 'a' || leftChar == 'e' || leftChar == 'i' || leftChar == 'o' || leftChar == 'u') {
                vowels[leftChar - 'a']--;
                if (vowels[leftChar - 'a'] == 0) {
                    vowelCount--;
                }
            } else {
                consonantCount--;
            }
            left++;
        }

        if (vowelCount == 5 && consonantCount == k) {
            count++;
        }
    }

    return count;
}
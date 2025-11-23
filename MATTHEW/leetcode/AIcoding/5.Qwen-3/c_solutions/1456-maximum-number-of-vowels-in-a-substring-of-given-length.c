#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxVowels(char *s, int k) {
    int n = strlen(s);
    int vowels[26] = {0};
    vowels['a' - 'a'] = 1;
    vowels['e' - 'a'] = 1;
    vowels['i' - 'a'] = 1;
    vowels['o' - 'a'] = 1;
    vowels['u' - 'a'] = 1;

    int maxCount = 0, currentCount = 0;

    for (int i = 0; i < k; i++) {
        if (vowels[s[i] - 'a']) {
            currentCount++;
        }
    }

    maxCount = currentCount;

    for (int i = k; i < n; i++) {
        if (vowels[s[i - k] - 'a']) {
            currentCount--;
        }
        if (vowels[s[i] - 'a']) {
            currentCount++;
        }
        if (currentCount > maxCount) {
            maxCount = currentCount;
        }
    }

    return maxCount;
}
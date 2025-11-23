#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int replaceSubstring(char* s, int k) {
    int n = strlen(s);
    int count[26] = {0};
    int maxCount = 0;
    int left = 0;
    int result = n;

    for (int right = 0; right < n; right++) {
        count[s[right] - 'a']++;
        maxCount = fmax(maxCount, count[s[right] - 'a']);

        while (right - left + 1 - maxCount > k) {
            count[s[left] - 'a']--;
            left++;
        }

        result = fmin(result, right - left + 1);
    }

    return result;
}
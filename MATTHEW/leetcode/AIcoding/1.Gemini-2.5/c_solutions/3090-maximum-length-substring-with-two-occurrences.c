#include <string.h>

int maxLengthSubstring(char *s) {
    int counts[26] = {0};
    int left = 0;
    int maxLength = 0;
    int n = strlen(s);

    if (n == 0) {
        return 0;
    }

    for (int right = 0; right < n; right++) {
        counts[s[right] - 'a']++;

        while (counts[s[right] - 'a'] > 2) {
            counts[s[left] - 'a']--;
            left++;
        }

        if (right - left + 1 > maxLength) {
            maxLength = right - left + 1;
        }
    }

    return maxLength;
}
#include <stdlib.h> // For abs

int equalSubstring(char * s, char * t, int maxCost) {
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }

    int left = 0;
    int currentCost = 0;
    int maxLength = 0;

    for (int right = 0; right < n; right++) {
        currentCost += abs(s[right] - t[right]);

        while (currentCost > maxCost) {
            currentCost -= abs(s[left] - t[left]);
            left++;
        }

        if (right - left + 1 > maxLength) {
            maxLength = right - left + 1;
        }
    }

    return maxLength;
}
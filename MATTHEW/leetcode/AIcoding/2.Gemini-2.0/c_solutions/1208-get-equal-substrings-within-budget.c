#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int equalSubstring(char * s, char * t, int cost[], int n, int maxCost){
    int left = 0, right = 0, currentCost = 0, maxLength = 0;
    while (right < n) {
        currentCost += abs(s[right] - t[right]);
        while (currentCost > maxCost) {
            currentCost -= abs(s[left] - t[left]);
            left++;
        }
        maxLength = (maxLength > (right - left + 1)) ? maxLength : (right - left + 1);
        right++;
    }
    return maxLength;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxNumOfSubstrings(char *s, int **intervals, int intervalsSize) {
    int n = strlen(s);
    int *minRight = (int *)malloc(n * sizeof(int));
    int *maxLeft = (int *)malloc(n * sizeof(int));
    int result = 0;

    for (int i = 0; i < n; i++) {
        minRight[i] = n;
        maxLeft[i] = -1;
    }

    for (int i = 0; i < n; i++) {
        int j = i;
        while (j < n && s[j] == s[i]) j++;
        j--; 
        int right = j;
        while (right < n && s[right] == s[i]) right++;
        right--; 
        minRight[i] = right - i + 1;

        for (int k = i; k <= right; k++) {
            if (s[k] < s[i]) {
                minRight[i] = n;
                break;
            }
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        int j = i;
        while (j >= 0 && s[j] == s[i]) j--;
        j++; 
        int left = j;
        while (left >= 0 && s[left] == s[i]) left--;
        left++; 
        maxLeft[i] = left - i + 1;

        for (int k = i; k >= left; k--) {
            if (s[k] < s[i]) {
                maxLeft[i] = -1;
                break;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (minRight[i] != n) {
            int j = minRight[i];
            while (j < n && maxLeft[j] != -1) {
                result++;
                j = maxLeft[j];
            }
        }
    }

    free(minRight);
    free(maxLeft);
    return result;
}
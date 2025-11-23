#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumScore(char * s, char * t) {
    int n = strlen(s);
    int m = strlen(t);
    int left[m + 1];
    int right[m + 1];

    left[0] = -1;
    int j = 0;
    for (int i = 0; i < n && j < m; i++) {
        if (s[i] == t[j]) {
            left[++j] = i;
        }
    }

    right[m] = n;
    j = m - 1;
    for (int i = n - 1; i >= 0 && j >= 0; i--) {
        if (s[i] == t[j]) {
            right[j--] = i;
        }
    }

    int ans = m;
    for (int i = 0; i <= m; i++) {
        int low = i, high = m;
        int k = -1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (right[mid] > left[i]) {
                k = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        if (k != -1) {
            ans = fmin(ans, k - i);
        } else {
            ans = fmin(ans, m - i);
        }
    }
    return ans;
}
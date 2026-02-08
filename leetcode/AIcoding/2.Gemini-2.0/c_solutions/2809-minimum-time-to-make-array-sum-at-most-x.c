#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minTime(int* nums1, int nums1Size, int* nums2, int nums2Size, int x) {
    int n = nums1Size;
    int sum1 = 0;
    for (int i = 0; i < n; i++) {
        sum1 += nums1[i];
    }
    int sum2 = 0;
    for (int i = 0; i < n; i++) {
        sum2 += nums2[i];
    }

    if (sum1 + sum2 * 0 <= x) {
        return 0;
    }

    int indices[n];
    for (int i = 0; i < n; i++) {
        indices[i] = i;
    }

    qsort(indices, n, sizeof(int), (int (*)(const void *, const void *))
          (
              [](const void *a, const void *b) -> int {
                  int indexA = *(int *)a;
                  int indexB = *(int *)b;
                  return nums2[indexB] - nums2[indexA];
              }
          ));

    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        int index = indices[i];
        for (int j = n - 1; j >= 0; j--) {
            if (dp[j] != INT_MAX) {
                dp[j + 1] = (dp[j + 1] < dp[j] + nums1[index] + (long long)nums2[index] * (j + 1) ? dp[j + 1] : dp[j] + nums1[index] + (long long)nums2[index] * (j + 1));
            }
        }
    }

    int ans = -1;
    for (int k = 0; k <= n; k++) {
        if ((long long)sum1 + (long long)sum2 * k - dp[k] <= x) {
            ans = k;
            break;
        }
    }

    return ans;
}
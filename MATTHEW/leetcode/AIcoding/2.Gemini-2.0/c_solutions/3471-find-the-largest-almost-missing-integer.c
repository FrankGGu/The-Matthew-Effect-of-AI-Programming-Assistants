#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int solve() {
    int n;
    scanf("%d", &n);

    int nums[n];
    for (int i = 0; i < n; i++) {
        scanf("%d", &nums[i]);
    }

    int count[101] = {0};
    for (int i = 0; i < n; i++) {
        if (nums[i] <= 100 && nums[i] >= 1) {
            count[nums[i]]++;
        }
    }

    int ans = -1;
    for (int i = 1; i <= 100; i++) {
        if (count[i] <= 1) {
            ans = i;
            break;
        }
    }

    if (ans == -1) {
        return 101;
    }

    return ans;
}
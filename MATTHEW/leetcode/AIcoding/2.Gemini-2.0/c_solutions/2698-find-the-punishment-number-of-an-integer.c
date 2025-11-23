#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool check(int n, int target) {
    char str[10];
    sprintf(str, "%d", n);
    int len = 0;
    while (str[len] != '\0') {
        len++;
    }

    bool solve(int idx, int sum) {
        if (idx == len) {
            return sum == target;
        }
        int num = 0;
        for (int i = idx; i < len; i++) {
            num = num * 10 + (str[i] - '0');
            if (solve(i + 1, sum + num)) {
                return true;
            }
        }
        return false;
    }

    return solve(0, 0);
}

int punishmentNumber(int n) {
    int ans = 0;
    for (int i = 1; i <= n; i++) {
        int sq = i * i;
        if (check(sq, i)) {
            ans += i * i;
        }
    }
    return ans;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dp[23][2][2][165];

int solve(char *num, int pos, bool tight_min, bool tight_max, int sum, int min_limit, int max_limit, int min_sum, int max_sum) {
    if (sum > max_sum) {
        return 0;
    }
    if (pos == strlen(num)) {
        return (sum >= min_sum);
    }

    if (dp[pos][tight_min][tight_max][sum] != -1) {
        return dp[pos][tight_min][tight_max][sum];
    }

    int start = tight_min ? (num[pos] - '0') : 0;
    int end = tight_max ? (num[pos] - '0') : 9;
    int ans = 0;

    for (int digit = start; digit <= end; digit++) {
        ans += solve(num, pos + 1, tight_min && (digit == start), tight_max && (digit == end), sum + digit, min_limit, max_limit, min_sum, max_sum);
    }

    return dp[pos][tight_min][tight_max][sum] = ans;
}

int count(char *num1, char *num2, int min_sum, int max_sum) {
    memset(dp, -1, sizeof(dp));
    int ans2 = solve(num2, 0, true, true, 0, atoi(num1), atoi(num2), min_sum, max_sum);

    memset(dp, -1, sizeof(dp));
    int len1 = strlen(num1);
    char *temp = (char *)malloc(sizeof(char) * (len1 + 2));
    int carry = 1;
    for (int i = len1 - 1; i >= 0; i--) {
        int digit = num1[i] - '0' - carry;
        if (digit < 0) {
            digit += 10;
            carry = 1;
        } else {
            carry = 0;
        }
        temp[i + 1] = digit + '0';
    }
    if (carry == 1) {
        temp[0] = '0' + 0;
        temp[len1 + 1] = '\0';
        char *new_num1 = (char *)malloc(sizeof(char) * (len1 + 2));
        strncpy(new_num1, temp, len1 + 2);
        new_num1[0] = '0';
        new_num1[len1 + 1] = '\0';

        memset(dp, -1, sizeof(dp));
        int ans1 = solve(new_num1, 0, true, true, 0, atoi(num1), atoi(num2), min_sum, max_sum);

        free(temp);
        free(new_num1);
        return ans2 - ans1;
    } else {
        temp[0] = '\0';
        for(int i = 1; i <= len1; i++) {
            temp[i-1] = temp[i];
        }
        temp[len1] = '\0';

        memset(dp, -1, sizeof(dp));
        int ans1 = solve(temp, 0, true, true, 0, atoi(num1), atoi(num2), min_sum, max_sum);
        free(temp);

        int sum = 0;
        for(int i = 0; i < len1; i++) {
            sum += num1[i] - '0';
        }
        if(sum >= min_sum && sum <= max_sum)
            return ans2 - ans1 + 1;
        else
            return ans2 - ans1;
    }
}
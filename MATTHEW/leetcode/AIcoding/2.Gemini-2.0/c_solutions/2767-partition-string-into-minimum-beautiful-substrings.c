#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPowerOfFive(int n) {
    if (n <= 0) return false;
    while (n % 5 == 0) {
        n /= 5;
    }
    return n == 1;
}

int beautifulPartitions(char * s, int k){
    int n = strlen(s);
    if (s[0] != '1') return -1;
    if (k == 1) {
        int num = 0;
        for (int i = 0; i < n; i++) {
            if (s[i] == '1') {
                int temp = 1;
                int count = 0;
                for (int j = i + 1; j < n && count < 10; j++) {
                    temp = temp * 2 + (s[j] - '0');
                    count++;
                }
                if (isPowerOfFive(temp)) {
                    num++;
                }
            }
        }
        if(num == 0) return -1;
        else return 1;
    }

    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = -1;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        if (dp[i] == -1) continue;
        for (int j = i + 1; j <= n; j++) {
            char sub[j - i + 1];
            strncpy(sub, s + i, j - i);
            sub[j - i] = '\0';

            int num = 0;
            if (sub[0] == '1') {
                for(int l = 0; l < strlen(sub); l++) {
                    num = num * 2 + (sub[l] - '0');
                }
                if (isPowerOfFive(num)) {
                    if (dp[j] == -1 || dp[j] > dp[i] + 1) {
                        dp[j] = dp[i] + 1;
                    }
                }
            }
        }
    }

    if (dp[n] == -1 || dp[n] > k) return -1;
    return dp[n];
}
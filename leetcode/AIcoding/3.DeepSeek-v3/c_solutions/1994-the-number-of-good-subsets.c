int prime[] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
int mod = 1e9 + 7;

int numberOfGoodSubsets(int* nums, int numsSize) {
    int freq[31];
    memset(freq, 0, sizeof(freq));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    int mask[31];
    memset(mask, 0, sizeof(mask));
    for (int i = 2; i <= 30; i++) {
        int tmp = i;
        int m = 0;
        for (int j = 0; j < 10; j++) {
            int cnt = 0;
            while (tmp % prime[j] == 0) {
                cnt++;
                tmp /= prime[j];
            }
            if (cnt > 1) {
                mask[i] = -1;
                break;
            } else if (cnt == 1) {
                m |= (1 << j);
            }
        }
        if (mask[i] != -1) {
            mask[i] = m;
        }
    }

    long long dp[1 << 10];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (int i = 2; i <= 30; i++) {
        if (freq[i] == 0 || mask[i] == -1) continue;
        for (int j = (1 << 10) - 1; j >= 0; j--) {
            if ((j & mask[i]) == 0) {
                dp[j | mask[i]] = (dp[j | mask[i]] + dp[j] * freq[i]) % mod;
            }
        }
    }

    long long res = 0;
    for (int i = 1; i < (1 << 10); i++) {
        res = (res + dp[i]) % mod;
    }

    long long ones = 1;
    for (int i = 0; i < freq[1]; i++) {
        ones = (ones * 2) % mod;
    }
    res = (res * ones) % mod;

    return res;
}
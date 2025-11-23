/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
long long* kthSmallestAmount(int* coins, int coinsSize, int k, int* returnSize) {
    *returnSize = 1;
    long long* result = (long long*)malloc(sizeof(long long));

    long long left = 1, right = 1e18;
    while (left < right) {
        long long mid = left + (right - left) / 2;
        long long count = 0;

        for (int mask = 1; mask < (1 << coinsSize); mask++) {
            long long lcm_val = 1;
            int bits = 0;
            for (int i = 0; i < coinsSize; i++) {
                if (mask & (1 << i)) {
                    bits++;
                    long long g = gcd(lcm_val, coins[i]);
                    if (lcm_val > mid / (coins[i] / g)) {
                        lcm_val = mid + 1;
                        break;
                    }
                    lcm_val *= coins[i] / g;
                }
            }
            if (bits % 2 == 1) {
                count += mid / lcm_val;
            } else {
                count -= mid / lcm_val;
            }
        }

        if (count < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    *result = left;
    return result;
}

long long gcd(long long a, long long b) {
    while (b != 0) {
        long long temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}
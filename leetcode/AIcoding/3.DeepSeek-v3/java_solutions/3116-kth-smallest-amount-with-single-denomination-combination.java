class Solution {
    public long findKthSmallest(int[] coins, int k) {
        long left = 1, right = (long) 1e18;
        while (left < right) {
            long mid = left + (right - left) / 2;
            if (count(coins, mid) >= k) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private long count(int[] coins, long m) {
        long res = 0;
        int n = coins.length;
        for (int mask = 1; mask < (1 << n); mask++) {
            long lcm = 1;
            int bits = 0;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) != 0) {
                    bits++;
                    lcm = lcm * coins[i] / gcd(lcm, coins[i]);
                    if (lcm > m) break;
                }
            }
            if (bits % 2 == 1) {
                res += m / lcm;
            } else {
                res -= m / lcm;
            }
        }
        return res;
    }

    private long gcd(long a, long b) {
        return b == 0 ? a : gcd(b, a % b);
    }
}
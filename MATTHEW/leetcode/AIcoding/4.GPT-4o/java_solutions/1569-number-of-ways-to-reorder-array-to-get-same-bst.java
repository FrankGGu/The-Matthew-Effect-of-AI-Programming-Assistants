import java.util.*;

class Solution {
    private static final int MOD = 1000000007;

    public int numOfWays(int[] nums) {
        return (int) (numOfWays(nums, 0, nums.length - 1) - 1 + MOD) % MOD;
    }

    private long numOfWays(int[] nums, int start, int end) {
        if (end - start <= 1) return 1;

        int root = nums[start];
        int leftCount = 0;
        for (int i = start + 1; i <= end; i++) {
            if (nums[i] < root) leftCount++;
        }
        int rightCount = end - start - leftCount;

        long leftWays = numOfWays(nums, start + 1, start + leftCount);
        long rightWays = numOfWays(nums, start + leftCount + 1, end);

        long combinations = combination(leftCount + rightCount, leftCount);
        return (leftWays * rightWays % MOD * combinations % MOD) % MOD;
    }

    private long combination(int n, int k) {
        if (k > n) return 0;
        long num = 1, denom = 1;
        for (int i = 0; i < k; i++) {
            num = num * (n - i) % MOD;
            denom = denom * (i + 1) % MOD;
        }
        return num * modInverse(denom, MOD) % MOD;
    }

    private long modInverse(long a, long m) {
        return power(a, m - 2, m);
    }

    private long power(long x, long y, long p) {
        long res = 1;
        x = x % p;
        while (y > 0) {
            if ((y & 1) == 1) res = res * x % p;
            y >>= 1;
            x = x * x % p;
        }
        return res;
    }
}
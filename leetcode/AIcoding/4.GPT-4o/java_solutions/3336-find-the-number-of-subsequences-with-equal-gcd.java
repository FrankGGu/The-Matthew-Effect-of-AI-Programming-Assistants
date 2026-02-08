import java.util.*;

class Solution {
    public int countSubsequences(int[] nums, int gcd) {
        int n = nums.length;
        long mod = 1000000007;
        Arrays.sort(nums);
        long count = 0;

        for (int i = 1; i <= gcd; i++) {
            if (gcd % i == 0) {
                long total = 0;
                for (int num : nums) {
                    if (num % i == 0) {
                        total++;
                    }
                }
                if (total > 0) {
                    count = (count + (pow(2, total, mod) - 1)) % mod;
                }
            }
        }

        return (int) count;
    }

    private long pow(long x, long y, long p) {
        long res = 1;
        x = x % p; 
        while (y > 0) {
            if ((y & 1) == 1) {
                res = (res * x) % p;
            }
            y = y >> 1;
            x = (x * x) % p;
        }
        return res;
    }
}
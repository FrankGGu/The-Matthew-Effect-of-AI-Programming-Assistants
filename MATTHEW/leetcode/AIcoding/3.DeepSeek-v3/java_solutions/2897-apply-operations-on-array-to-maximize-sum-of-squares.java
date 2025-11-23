import java.util.*;

class Solution {
    public int maxSum(List<Integer> nums, int k) {
        final int MOD = 1_000_000_007;
        int[] cnt = new int[31];
        for (int num : nums) {
            for (int i = 0; i < 31; i++) {
                if (((num >> i) & 1) == 1) {
                    cnt[i]++;
                }
            }
        }

        long res = 0;
        for (int i = 0; i < k; i++) {
            long x = 0;
            for (int j = 0; j < 31; j++) {
                if (cnt[j] > 0) {
                    x |= (1 << j);
                    cnt[j]--;
                }
            }
            res = (res + x * x) % MOD;
        }
        return (int) res;
    }
}
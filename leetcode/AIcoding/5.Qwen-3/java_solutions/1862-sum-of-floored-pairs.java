public class Solution {

import java.util.*;

public class Solution {
    public int sumOfFlooredPairs(int[] nums) {
        int maxNum = 0;
        for (int num : nums) {
            maxNum = Math.max(maxNum, num);
        }
        int[] freq = new int[maxNum + 1];
        for (int num : nums) {
            freq[num]++;
        }
        int MOD = 1000000007;
        int[] prefix = new int[maxNum + 2];
        for (int i = 1; i <= maxNum; i++) {
            prefix[i] = (prefix[i - 1] + freq[i]) % MOD;
        }
        int result = 0;
        for (int a = 1; a <= maxNum; a++) {
            if (freq[a] == 0) continue;
            for (int k = 1; k * a <= maxNum; k++) {
                int lower = k * a;
                int upper = (k + 1) * a - 1;
                int count = prefix[Math.min(upper, maxNum)] - prefix[lower - 1];
                if (lower > 0) count += freq[lower - 1];
                result = (result + (long) freq[a] * count) % MOD;
            }
        }
        return result;
    }
}
}
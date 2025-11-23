import java.util.HashMap;
import java.util.Map;

class Solution {
    public int countNicePairs(int[] nums) {
        final int MOD = 1_000_000_007;
        Map<Integer, Integer> freqMap = new HashMap<>();
        long count = 0;

        for (int num : nums) {
            int diff = num - reverse(num);

            int currentFreq = freqMap.getOrDefault(diff, 0);
            count = (count + currentFreq) % MOD;

            freqMap.put(diff, currentFreq + 1);
        }

        return (int) count;
    }

    private int reverse(int n) {
        int reversedNum = 0;
        while (n > 0) {
            int digit = n % 10;
            reversedNum = reversedNum * 10 + digit;
            n /= 10;
        }
        return reversedNum;
    }
}
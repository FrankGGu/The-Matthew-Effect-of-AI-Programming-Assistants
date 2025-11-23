import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minimumArrayLength(int[] nums) {
        Map<Integer, Integer> freqMap = new HashMap<>();
        int maxFreq = 0;
        for (int num : nums) {
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
            maxFreq = Math.max(maxFreq, freqMap.get(num));
        }

        int n = nums.length;

        if (maxFreq > n / 2) {
            return 2 * maxFreq - n;
        } else {
            return n % 2;
        }
    }
}
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minimumOperations(int[] nums, int k) {
        int n = nums.length;
        int totalOperations = 0;

        for (int i = 0; i < k; i++) {
            Map<Integer, Integer> freqMap = new HashMap<>();
            int groupSize = 0;
            int maxFreq = 0;

            for (int j = i; j < n; j += k) {
                freqMap.put(nums[j], freqMap.getOrDefault(nums[j], 0) + 1);
                groupSize++;
            }

            for (int freq : freqMap.values()) {
                if (freq > maxFreq) {
                    maxFreq = freq;
                }
            }

            if (groupSize > 0) {
                totalOperations += (groupSize - maxFreq);
            }
        }

        return totalOperations;
    }
}
import java.util.HashMap;
import java.util.Map;

class Solution {
    public long countBadPairs(int[] nums) {
        int n = nums.length;
        long totalPairs = (long) n * (n - 1) / 2;
        long goodPairs = 0;

        Map<Integer, Integer> freqMap = new HashMap<>();

        for (int i = 0; i < n; i++) {
            int key = nums[i] - i;
            freqMap.put(key, freqMap.getOrDefault(key, 0) + 1);
        }

        for (int count : freqMap.values()) {
            goodPairs += (long) count * (count - 1) / 2;
        }

        return totalPairs - goodPairs;
    }
}
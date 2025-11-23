import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numberOfGoodPartitions(int[] nums) {
        Map<Integer, Integer> lastOccurrence = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            lastOccurrence.put(nums[i], i);
        }

        int maxIndex = 0;
        int partitions = 0;
        int mod = 1000000007;

        for (int i = 0; i < nums.length; i++) {
            maxIndex = Math.max(maxIndex, lastOccurrence.get(nums[i]));
            if (i == maxIndex) {
                partitions++;
            }
        }

        if (partitions == 0) return 0;

        long result = 1;
        for (int i = 1; i < partitions; i++) {
            result = (result * 2) % mod;
        }

        return (int) result;
    }
}
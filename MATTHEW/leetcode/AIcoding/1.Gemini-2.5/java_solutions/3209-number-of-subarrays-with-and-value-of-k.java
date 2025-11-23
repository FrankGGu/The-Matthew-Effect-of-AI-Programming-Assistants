import java.util.HashMap;
import java.util.Map;

class Solution {
    public long subarraysWithAndValue(int[] nums, int k) {
        long ans = 0;
        // currentAndCounts stores (AND_value, count) for subarrays ending at the previous index.
        // The number of distinct AND values for subarrays ending at any given index is at most log(MAX_VAL).
        Map<Integer, Integer> currentAndCounts = new HashMap<>(); 

        for (int num : nums) {
            // nextAndCounts will store (AND_value, count) for subarrays ending at the current index.
            Map<Integer, Integer> nextAndCounts = new HashMap<>(); 

            // Extend all existing subarrays by performing a bitwise AND with the current 'num'.
            for (Map.Entry<Integer, Integer> entry : currentAndCounts.entrySet()) {
                int andVal = entry.getKey();
                int count = entry.getValue();
                int newAndVal = andVal & num;
                nextAndCounts.put(newAndVal, nextAndCounts.getOrDefault(newAndVal, 0) + count);
            }

            // Add the current 'num' itself as a subarray of length 1.
            nextAndCounts.put(num, nextAndCounts.getOrDefault(num, 0) + 1);

            // Count how many subarrays ending at the current index have an AND value equal to 'k'.
            ans += nextAndCounts.getOrDefault(k, 0);

            // Update currentAndCounts for the next iteration.
            currentAndCounts = nextAndCounts;
        }

        return ans;
    }
}
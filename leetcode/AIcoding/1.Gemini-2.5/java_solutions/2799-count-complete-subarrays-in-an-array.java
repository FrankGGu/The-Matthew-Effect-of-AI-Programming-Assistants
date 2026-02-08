import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public long countCompleteSubarrays(int[] nums) {
        int n = nums.length;

        Set<Integer> distinctElementsInNums = new HashSet<>();
        for (int x : nums) {
            distinctElementsInNums.add(x);
        }
        int k = distinctElementsInNums.size();

        long totalCompleteSubarrays = 0;

        for (int i = 0; i < n; i++) {
            Map<Integer, Integer> freqMap = new HashMap<>();
            int currentDistinctCount = 0;

            for (int j = i; j < n; j++) {
                freqMap.put(nums[j], freqMap.getOrDefault(nums[j], 0) + 1);

                if (freqMap.get(nums[j]) == 1) {
                    currentDistinctCount++;
                }

                if (currentDistinctCount == k) {
                    totalCompleteSubarrays += (n - j);
                    break;
                }
            }
        }

        return totalCompleteSubarrays;
    }
}
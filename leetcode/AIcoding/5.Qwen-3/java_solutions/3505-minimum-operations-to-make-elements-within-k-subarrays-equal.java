public class Solution {

import java.util.*;

public class Solution {
    public int minimumOperationsToMakeElementsWithinKSubarraysEqual(int[] nums, int k) {
        int n = nums.length;
        Map<Integer, Integer> freq = new HashMap<>();
        for (int i = 0; i < k; i++) {
            freq.put(nums[i], freq.getOrDefault(nums[i], 0) + 1);
        }
        int maxFreq = Collections.max(freq.values());
        int operations = k - maxFreq;

        for (int i = k; i < n; i++) {
            freq.put(nums[i - k], freq.get(nums[i - k]) - 1);
            if (freq.get(nums[i - k]) == 0) {
                freq.remove(nums[i - k]);
            }
            freq.put(nums[i], freq.getOrDefault(nums[i], 0) + 1);
            maxFreq = Collections.max(freq.values());
            operations += k - maxFreq;
        }

        return operations;
    }
}
}
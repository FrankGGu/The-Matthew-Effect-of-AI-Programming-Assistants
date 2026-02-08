public class Solution {

import java.util.*;

public class Solution {
    public int numSubarraysWithSum(int[] nums, int k) {
        int count = 0;
        int prefixSum = 0;
        Map<Integer, Integer> sumCounts = new HashMap<>();
        sumCounts.put(0, 1);

        for (int num : nums) {
            prefixSum += num;
            count += sumCounts.getOrDefault(prefixSum - k, 0);
            sumCounts.put(prefixSum, sumCounts.getOrDefault(prefixSum, 0) + 1);
        }

        return count;
    }
}
}
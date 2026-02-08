public class Solution {

import java.util.*;

public class Solution {
    public int maximumGoodSubarraySum(int[] nums) {
        int maxSum = 0;
        int currentSum = 0;
        Set<Integer> seen = new HashSet<>();

        for (int num : nums) {
            if (seen.contains(num)) {
                currentSum = 0;
                seen.clear();
            }
            currentSum += num;
            seen.add(num);
            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}
}
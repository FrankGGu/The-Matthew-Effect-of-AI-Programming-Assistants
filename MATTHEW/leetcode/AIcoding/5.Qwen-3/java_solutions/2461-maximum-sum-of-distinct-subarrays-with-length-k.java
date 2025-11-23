public class Solution {

import java.util.*;

public class Solution {
    public long maximumSubarraySum(int[] nums, int k) {
        Map<Integer, Integer> count = new HashMap<>();
        long currentSum = 0;
        long maxSum = 0;
        boolean hasDistinct = true;

        for (int i = 0; i < nums.length; i++) {
            if (i >= k) {
                int left = nums[i - k];
                count.put(left, count.get(left) - 1);
                if (count.get(left) == 0) {
                    count.remove(left);
                }
                currentSum -= left;
            }

            int num = nums[i];
            if (count.containsKey(num)) {
                hasDistinct = false;
            } else {
                hasDistinct = true;
            }

            count.put(num, count.getOrDefault(num, 0) + 1);
            currentSum += num;

            if (i >= k - 1) {
                if (hasDistinct && count.size() == k) {
                    maxSum = Math.max(maxSum, currentSum);
                }
            }
        }

        return maxSum;
    }
}
}
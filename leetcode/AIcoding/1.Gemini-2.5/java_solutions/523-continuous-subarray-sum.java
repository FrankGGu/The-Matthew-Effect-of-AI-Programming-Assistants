import java.util.HashMap;

class Solution {
    public boolean checkSubarraySum(int[] nums, int k) {
        HashMap<Long, Integer> map = new HashMap<>();
        map.put(0L, -1); // Initialize with a prefix sum of 0 at index -1
        long currentSum = 0;

        for (int i = 0; i < nums.length; i++) {
            currentSum += nums[i];

            if (k != 0) {
                // For k != 0, we care about the remainder.
                // The expression (currentSum % k + k) % k ensures a non-negative remainder
                // even if currentSum is negative.
                currentSum = (currentSum % k + k) % k;
            }
            // If k is 0, currentSum is used as is (we are looking for a subarray sum of 0).

            if (map.containsKey(currentSum)) {
                // If we've seen this currentSum (or remainder) before,
                // it means the subarray between the previous occurrence's index and current index
                // sums to a multiple of k.
                // We need to check if the length of this subarray is at least 2.
                if (i - map.get(currentSum) >= 2) {
                    return true;
                }
            } else {
                // If this currentSum (or remainder) is new, store its first occurrence index.
                map.put(currentSum, i);
            }
        }

        return false;
    }
}
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int smallestMissingInteger(int[] nums) {
        // Step 1: Calculate the sequential prefix sum
        // The sequential prefix starts with nums[0].
        // It extends as long as nums[i] is exactly nums[i-1] + 1.
        int prefixSum = nums[0];
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] == nums[i - 1] + 1) {
                prefixSum += nums[i];
            } else {
                // The sequential property is broken, stop extending the prefix.
                break;
            }
        }

        // Step 2: Store all numbers from nums into a HashSet for efficient lookup.
        // This allows checking for existence of a number in O(1) average time.
        Set<Integer> seen = new HashSet<>();
        for (int num : nums) {
            seen.add(num);
        }

        // Step 3: Find the smallest missing integer strictly greater than prefixSum.
        // We start checking from prefixSum + 1 and increment until we find a number
        // that is not present in the 'seen' set.
        int currentCheck = prefixSum + 1;
        while (seen.contains(currentCheck)) {
            currentCheck++;
        }

        return currentCheck;
    }
}
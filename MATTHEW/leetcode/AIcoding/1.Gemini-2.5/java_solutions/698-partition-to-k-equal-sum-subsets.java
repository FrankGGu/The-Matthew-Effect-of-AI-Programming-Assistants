import java.util.Arrays;
import java.util.Collections;

class Solution {
    public boolean canPartitionKSubsets(int[] nums, int k) {
        int totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        if (totalSum % k != 0) {
            return false;
        }

        int targetSum = totalSum / k;

        // Convert to Integer array for reverse sorting
        Integer[] numsObj = new Integer[nums.length];
        for (int i = 0; i < nums.length; i++) {
            numsObj[i] = nums[i];
        }
        Arrays.sort(numsObj, Collections.reverseOrder());
        // Copy back to primitive array
        for (int i = 0; i < nums.length; i++) {
            nums[i] = numsObj[i];
        }

        // Optimization: If the largest number is greater than targetSum, it's impossible.
        if (nums[0] > targetSum) {
             return false;
        }

        int[] buckets = new int[k]; // Stores current sum for each of the k buckets

        return backtrack(nums, buckets, targetSum, 0);
    }

    private boolean backtrack(int[] nums, int[] buckets, int targetSum, int index) {
        // Base case: If all numbers have been successfully placed
        if (index == nums.length) {
            // All numbers placed, implies all buckets are filled to targetSum (due to initial totalSum % k == 0 check)
            return true;
        }

        // Try to place nums[index] into one of the k buckets
        for (int i = 0; i < buckets.length; i++) {
            // If nums[index] can fit into bucket[i]
            if (buckets[i] + nums[index] <= targetSum) {
                buckets[i] += nums[index]; // Place the number

                // Recursively try to place the next number
                if (backtrack(nums, buckets, targetSum, index + 1)) {
                    return true; // If successful, propagate true
                }

                buckets[i] -= nums[index]; // Backtrack: remove the number
            }

            // Optimization: If we just tried to put nums[index] into an empty bucket (buckets[i] was 0
            // before adding nums[index], and is 0 again after backtracking) and it failed,
            // then there's no need to try other empty buckets for nums[index].
            // This is because all empty buckets are symmetrical.
            // This check must be placed here, *after* backtracking, and applies only if the bucket was empty.
            if (buckets[i] == 0) { // If bucket was empty before trying nums[index] and the attempt failed
                break; // Prune: all subsequent empty buckets are symmetrical, no need to try them
            }
        }

        // If nums[index] couldn't be placed in any bucket
        return false;
    }
}
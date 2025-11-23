import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    private int beautifulSubsetsCount;
    private int k;
    private int[] nums;

    public int beautifulSubsets(int[] nums, int k) {
        this.k = k;
        this.nums = nums;
        this.beautifulSubsetsCount = 0;

        // Sort the array to ensure that when we consider nums[index],
        // any potential conflicting element (nums[index] - k) would have a smaller index.
        Arrays.sort(this.nums);

        backtrack(0, new HashMap<>());

        return beautifulSubsetsCount;
    }

    private void backtrack(int index, Map<Integer, Integer> countMap) {
        // Base case: All elements have been considered
        if (index == nums.length) {
            // If the current subset is not empty, it is a beautiful subset
            if (!countMap.isEmpty()) {
                beautifulSubsetsCount++;
            }
            return;
        }

        // Option 1: Exclude nums[index] from the current subset
        backtrack(index + 1, countMap);

        // Option 2: Include nums[index] in the current subset
        // Check if including nums[index] violates the beautiful subset condition.
        // We only need to check for nums[index] - k because nums is sorted.
        // If nums[index] + k were present, it would have been considered at an earlier index
        // and would have been checked against nums[index].
        if (countMap.getOrDefault(nums[index] - k, 0) == 0) {
            // Include nums[index]
            countMap.put(nums[index], countMap.getOrDefault(nums[index], 0) + 1);

            // Recurse with nums[index] included
            backtrack(index + 1, countMap);

            // Backtrack: Remove nums[index] to explore other possibilities
            countMap.put(nums[index], countMap.get(nums[index]) - 1);
            if (countMap.get(nums[index]) == 0) {
                countMap.remove(nums[index]);
            }
        }
    }
}
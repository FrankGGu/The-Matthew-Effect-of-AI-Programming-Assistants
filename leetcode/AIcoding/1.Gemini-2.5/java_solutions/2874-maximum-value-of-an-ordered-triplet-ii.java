class Solution {
    public long maximumTripletValue(int[] nums) {
        int n = nums.length;

        // maxA stores the maximum value of nums[i] found so far, for i < j.
        // It is updated as we iterate through the array.
        // For the first possible 'j' (which is 1), the only 'i' is 0, so maxA starts with nums[0].
        int maxA = nums[0]; 

        // maxAB stores the maximum value of (nums[i] - nums[j]) found so far, for i < j < k.
        // This value is used to multiply with nums[k].
        // Initialize with the difference for the first possible (i,j) pair: (0, 1).
        // It needs to be long because the difference can be large and will be multiplied by nums[k].
        long maxAB = (long)nums[0] - nums[1]; 

        // max_triplet_value stores the overall maximum value of (nums[i] - nums[j]) * nums[k].
        // Initialize with 0L as per the problem statement (return 0 if all triplets have negative value).
        long max_triplet_value = 0L;

        // Iterate through the array starting from index 2.
        // `idx` represents the index 'k' in the triplet (nums[i] - nums[j]) * nums[k].
        // The constraints are 0 <= i < j < k < nums.length, so k must be at least 2.
        for (int idx = 2; idx < n; idx++) {
            // 1. Calculate the triplet value using the current `nums[idx]` (as `nums[k]`).
            // `maxAB` at this point holds the maximum (nums[i] - nums[j]) for all i < j where j is up to `idx-1`.
            max_triplet_value = Math.max(max_triplet_value, maxAB * nums[idx]);

            // 2. Update `maxA`. `nums[idx-1]` is now a candidate for `nums[i]` for future triplets.
            // `maxA` will now represent `max(nums[0], ..., nums[idx-1])`.
            maxA = Math.max(maxA, nums[idx-1]);

            // 3. Update `maxAB`. `nums[idx]` is now a candidate for `nums[j]` for future triplets.
            // We calculate a new potential (nums[i] - nums[j]) using the updated `maxA` and `nums[idx]`.
            // `maxAB` will then represent `max(nums[i] - nums[j])` for `i < j` where `j` is up to `idx`.
            maxAB = Math.max(maxAB, (long)maxA - nums[idx]);
        }

        return max_triplet_value;
    }
}
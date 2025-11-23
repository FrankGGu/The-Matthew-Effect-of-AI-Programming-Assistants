impl Solution {
    pub fn partition_disjoint(nums: Vec<i32>) -> i32 {
        let n = nums.len();

        // max_left_seen: The maximum value in the current candidate left partition (nums[0...ans-1]).
        // This represents the maximum value that *must* be in the left partition.
        let mut max_left_seen = nums[0];

        // current_max: The maximum value encountered so far in nums[0...i].
        // This tracks the overall maximum as we iterate through the array.
        let mut current_max = nums[0];

        // ans: The length of the left partition. Initialized to 1, meaning nums[0] is the left partition.
        let mut ans = 1; 

        // Iterate from the second element (index 1) to the end of the array.
        for i in 1..n {
            // Update the overall maximum encountered up to the current index i.
            current_max = current_max.max(nums[i]);

            // If the current element nums[i] is smaller than max_left_seen,
            // it means nums[i] cannot be in the right partition if max_left_seen
            // is truly the maximum of the left partition (because max(left) <= min(right) must hold).
            // This forces us to extend the left partition to include nums[i].
            if nums[i] < max_left_seen {
                // The new length of the left partition becomes i + 1.
                ans = i + 1;
                // Since the left partition now extends to index i, its new maximum value
                // must be the overall maximum encountered up to this point (current_max).
                max_left_seen = current_max;
            }
            // If nums[i] >= max_left_seen, it means nums[i] can potentially be in the right partition
            // without violating the condition (max_left_seen <= nums[i]).
            // We do not update 'ans' or 'max_left_seen' in this case because we are looking for the *smallest*
            // valid partition, and the current 'ans' is still a candidate. We just keep tracking 'current_max'
            // in case a future element forces the partition boundary to move.
        }

        // The problem guarantees that such a partition exists, so 'ans' will always be less than 'n'.
        ans as i32
    }
}
impl Solution {
    pub fn maximum_value_of_an_ordered_triplet(nums: Vec<i32>) -> i64 {
        let n = nums.len();

        // max_val_i: Stores the maximum nums[p] encountered so far, for p < current_idx.
        // This value represents max(nums[i]) for the purpose of calculating (nums[i] - nums[j]).
        let mut max_val_i: i64 = nums[0] as i64;

        // max_val_i_minus_j: Stores the maximum (nums[p] - nums[q]) encountered so far, for p < q < current_idx.
        // This value represents max(nums[i] - nums[j]) for the purpose of calculating (max_val_i_minus_j * nums[k]).
        // Initialized to i64::MIN to correctly handle cases where all differences are negative.
        let mut max_val_i_minus_j: i64 = i64::MIN;

        // max_triplet_val: Stores the maximum value of (nums[i] - nums[j]) * nums[k] found.
        // Initialized to 0 as per problem statement ("return 0 if no such triplet exists or all triplets have a negative value").
        let mut max_triplet_val: i64 = 0;

        // Iterate through the array starting from the second element (index 1).
        // In each iteration, current_num acts as nums[k] for the triplet calculation,
        // and then as nums[j] for updating max_val_i_minus_j,
        // and finally as nums[i] for updating max_val_i for future iterations.
        for current_idx in 1..n {
            let current_num = nums[current_idx] as i64;

            // Step 1: Calculate potential triplet value using current_num as nums[k].
            // max_val_i_minus_j holds max(nums[i] - nums[j]) for i < j < current_idx.
            // This ensures that i, j, and k indices are strictly increasing.
            max_triplet_val = max_triplet_val.max(max_val_i_minus_j * current_num);

            // Step 2: Update max_val_i_minus_j using current_num as nums[j].
            // max_val_i holds max(nums[i]) for i < current_idx.
            // This updates max_val_i_minus_j to consider current_idx as the 'j' index.
            max_val_i_minus_j = max_val_i_minus_j.max(max_val_i - current_num);

            // Step 3: Update max_val_i to include current_num.
            // This prepares max_val_i for the next iteration, where current_num might be nums[i] for a new 'j'.
            max_val_i = max_val_i.max(current_num);
        }

        max_triplet_val
    }
}
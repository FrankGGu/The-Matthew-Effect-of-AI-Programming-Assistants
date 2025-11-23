impl Solution {
    pub fn triples_with_bitwise_and_equal_to_zero(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        // The maximum value for nums[i] is 2^16 - 1.
        // We need an array of size 2^16 to cover all possible values from 0 to 2^16 - 1.
        const MAX_VAL_EXCLUSIVE: usize = 1 << 16; // 2^16

        // Step 1: Count frequencies of each number in `nums`.
        // `count_val[v]` stores how many times `v` appears in `nums`.
        let mut count_val = vec![0; MAX_VAL_EXCLUSIVE];
        for &num in nums.iter() {
            count_val[num as usize] += 1;
        }

        // Step 2: Compute `g[mask]` using Sum Over Subsets (SOS) DP.
        // `g[mask]` will store the count of numbers `v` in `nums` such that `v` is a submask of `mask`.
        // That is, `g[mask] = sum_{submask \subseteq mask} count_val[submask]`.
        let mut g = count_val.clone();

        for i in 0..16 { // Iterate over each bit position (0 to 15)
            for mask in 0..MAX_VAL_EXCLUSIVE { // Iterate over all possible masks
                if (mask >> i) & 1 == 1 { // If the i-th bit is set in `mask`
                    // Add the count from the mask where the i-th bit is not set.
                    // This accumulates counts for all submasks.
                    g[mask] += g[mask ^ (1 << i)];
                }
            }
        }

        // Step 3: Compute `freq_and[x]`.
        // `freq_and[x]` stores the count of pairs `(nums[i], nums[j])` such that `(nums[i] & nums[j]) == x`.
        let mut freq_and = vec![0; MAX_VAL_EXCLUSIVE];
        for &num1 in nums.iter() {
            for &num2 in nums.iter() {
                freq_and[(num1 & num2) as usize] += 1;
            }
        }

        let mut total_triples = 0;
        // `all_bits_mask` represents 0xFFFF (all 16 bits set), which is 2^16 - 1.
        let all_bits_mask = MAX_VAL_EXCLUSIVE - 1;

        // Step 4: Calculate the total number of triples.
        // For each possible value `x` (which is `nums[i] & nums[j]`),
        // we need to find `k` such that `x & nums[k] == 0`.
        // This condition `x & nums[k] == 0` means that `nums[k]` must not have any bits set
        // where `x` has bits set. In other words, `nums[k]` must be a submask of `(all_bits_mask ^ x)`.
        // The count of such `nums[k]` values is precisely `g[all_bits_mask ^ x]`.
        for x in 0..MAX_VAL_EXCLUSIVE {
            if freq_and[x] == 0 {
                continue;
            }
            // `count_num3_for_x` is the number of `nums[k]` values such that `x & nums[k] == 0`.
            let count_num3_for_x = g[all_bits_mask ^ x];
            total_triples += freq_and[x] * count_num3_for_x;
        }

        total_triples
    }
}
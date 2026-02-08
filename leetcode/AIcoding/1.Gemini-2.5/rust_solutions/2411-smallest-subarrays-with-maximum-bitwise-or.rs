impl Solution {
    pub fn smallest_subarrays(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut ans = vec![0; n];

        // Calculate the maximum possible bitwise OR for any subarray of nums.
        // This is the bitwise OR of all elements in the entire array.
        let mut total_or = 0;
        for &num in &nums {
            total_or |= num;
        }

        // `pos_of_bit[b]` stores the index of the rightmost element (from current `i` to `N-1`)
        // that has bit `b` set. Initialize with `n` (a sentinel value indicating not found).
        let mut pos_of_bit = vec![n; 30]; // Max 30 bits for 10^9

        // Iterate from right to left (from N-1 down to 0)
        for i in (0..n).rev() {
            let mut current_max_j = i; // Smallest possible subarray is nums[i..i], so j starts at i.
            let mut impossible_to_achieve_total_or = false;

            // For each bit position
            for bit_idx in 0..30 {
                // If this bit must be set in the final OR (i.e., it's set in `total_or`)
                if ((total_or >> bit_idx) & 1) == 1 {
                    // If nums[i] itself does not have this bit set
                    if ((nums[i] >> bit_idx) & 1) == 0 {
                        // We need to find this bit in an element to the right of `i`.
                        // `pos_of_bit[bit_idx]` gives the index of the closest such element.
                        if pos_of_bit[bit_idx] == n {
                            // If `pos_of_bit[bit_idx]` is `n`, it means this bit is not found
                            // in `nums[i+1..N-1]` (and not in `nums[i]` either).
                            // This implies it's impossible to achieve `total_or` starting from `i`.
                            impossible_to_achieve_total_or = true;
                            break; // No need to check other bits for this `i`
                        } else {
                            // Update `current_max_j` to ensure this bit is covered.
                            current_max_j = current_max_j.max(pos_of_bit[bit_idx]);
                        }
                    }
                }
            }

            if impossible_to_achieve_total_or {
                // If it's impossible to achieve `total_or` starting from `i`,
                // the problem implies the answer is 1 (subarray `nums[i..i]`).
                ans[i] = 1;
            } else {
                // The length of the smallest subarray `nums[i..j]` is `j - i + 1`.
                ans[i] = (current_max_j - i + 1) as i32;
            }

            // After calculating `ans[i]`, update `pos_of_bit` based on `nums[i]`.
            // This makes `pos_of_bit` ready for the next iteration (i-1).
            for bit_idx in 0..30 {
                if ((nums[i] >> bit_idx) & 1) == 1 {
                    pos_of_bit[bit_idx] = i;
                }
            }
        }

        ans
    }
}
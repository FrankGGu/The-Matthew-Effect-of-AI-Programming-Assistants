use std::collections::HashMap;

impl Solution {
    pub fn recover_array(mut nums: Vec<i32>) -> Vec<i32> {
        nums.sort_unstable(); // Sort the array to easily find pairs and process in order

        let n = nums.len() / 2;

        // Create a frequency map for the numbers in nums.
        // This allows efficient lookup and tracking of used numbers.
        let mut initial_freq_map: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *initial_freq_map.entry(num).or_insert(0) += 1;
        }

        // nums[0] must be an 'x - k' value for some x in the original array.
        // We iterate through possible nums[j] values that could be its corresponding 'x + k'.
        // If nums[j] is 'x + k' for nums[0] being 'x - k', then:
        // nums[j] - nums[0] = (x + k) - (x - k) = 2k.
        // So, k = (nums[j] - nums[0]) / 2.
        for j in 1..nums.len() {
            let diff = nums[j] - nums[0];

            // 2k must be a positive even number.
            if diff <= 0 || diff % 2 != 0 {
                continue;
            }

            let k = diff / 2;
            let mut current_arr: Vec<i32> = Vec::with_capacity(n);
            let mut freq_map = initial_freq_map.clone(); // Use a fresh frequency map for each potential k

            let mut possible_k_works = true;
            for &num in &nums {
                // If this 'num' has not been used yet (its count in freq_map is > 0)
                if let Some(count) = freq_map.get_mut(&num) {
                    if *count > 0 {
                        // This 'num' is a candidate for 'x - k'. Mark it as used.
                        *count -= 1;

                        // The corresponding 'x + k' value should be 'num + 2k'.
                        let target_x_plus_k = num + 2 * k;

                        // Check if 'target_x_plus_k' exists and is available.
                        if let Some(target_count) = freq_map.get_mut(&target_x_plus_k) {
                            if *target_count > 0 {
                                // Found its pair 'x + k'. Mark it as used.
                                *target_count -= 1;
                                // Add 'x' (which is num + k) to our candidate array.
                                current_arr.push(num + k);
                            } else {
                                // Pair not available (already used or not enough count).
                                // This 'k' is invalid.
                                possible_k_works = false;
                                break;
                            }
                        } else {
                            // Pair not found in the map at all. This 'k' is invalid.
                            possible_k_works = false;
                            break;
                        }
                    }
                }
            }

            // If we successfully formed 'n' pairs and used all numbers in nums,
            // then this 'k' is correct, and current_arr is the solution.
            if possible_k_works && current_arr.len() == n {
                return current_arr;
            }
        }

        // According to the problem statement, a valid array is guaranteed to exist.
        // So, this line should theoretically not be reached.
        unreachable!()
    }
}
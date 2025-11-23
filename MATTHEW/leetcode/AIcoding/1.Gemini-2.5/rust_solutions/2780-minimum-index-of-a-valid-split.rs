impl Solution {
    pub fn minimum_index(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 2 {
            return -1;
        }

        // Step 1: Find the dominant element for the entire array using Boyer-Moore Majority Vote Algorithm
        let mut candidate = 0;
        let mut count = 0;

        for &num in &nums {
            if count == 0 {
                candidate = num;
                count = 1;
            } else if num == candidate {
                count += 1;
            } else {
                count -= 1;
            }
        }

        // Verify if the candidate is indeed a dominant element
        let mut total_dominant_count = 0;
        for &num in &nums {
            if num == candidate {
                total_dominant_count += 1;
            }
        }

        if total_dominant_count * 2 <= n {
            // No dominant element for the entire array, so no valid split is possible
            return -1;
        }

        let dominant_element = candidate;

        // Step 2: Iterate through possible split points k
        // k ranges from 0 to n-2 (inclusive)
        let mut left_dominant_count = 0;
        for k in 0..n - 1 {
            if nums[k] == dominant_element {
                left_dominant_count += 1;
            }

            let left_len = k + 1;
            let right_len = n - (k + 1);
            let right_dominant_count = total_dominant_count - left_dominant_count;

            // Check if the dominant_element is dominant in both subarrays
            let is_left_dominant = left_dominant_count * 2 > left_len;
            let is_right_dominant = right_dominant_count * 2 > right_len;

            if is_left_dominant && is_right_dominant {
                return k as i32;
            }
        }

        // No valid split found
        -1
    }
}
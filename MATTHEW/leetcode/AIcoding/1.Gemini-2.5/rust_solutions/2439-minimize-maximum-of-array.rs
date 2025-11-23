impl Solution {
    pub fn minimize_array_value(nums: Vec<i32>) -> i32 {
        let mut current_sum: i64 = 0;
        let mut max_avg: i64 = 0;

        for i in 0..nums.len() {
            current_sum += nums[i] as i64;
            let num_elements = (i + 1) as i64;
            // Calculate ceil(current_sum / num_elements) using integer division
            let avg = (current_sum + num_elements - 1) / num_elements;
            max_avg = max_avg.max(avg);
        }

        max_avg as i32
    }
}
impl Solution {
    pub fn sum_subarray_ranges(nums: Vec<i32>) -> i64 {
        let n = nums.len();

        let mut left_prev_greater = vec![-1; n];
        let mut right_next_greater_or_equal = vec![n as isize; n];
        let mut left_prev_smaller_or_equal = vec![-1; n];
        let mut right_next_smaller = vec![n as isize; n];

        let mut stack: Vec<usize> = Vec::with_capacity(n);

        // Calculate left_prev_greater: index of previous element strictly greater than nums[i]
        for i in 0..n {
            while !stack.is_empty() && nums[*stack.last().unwrap()] <= nums[i] {
                stack.pop();
            }
            if !stack.is_empty() {
                left_prev_greater[i] = *stack.last().unwrap() as isize;
            }
            stack.push(i);
        }
        stack.clear();

        // Calculate right_next_greater_or_equal: index of next element greater than or equal to nums[i]
        for i in (0..n).rev() {
            while !stack.is_empty() && nums[*stack.last().unwrap()] < nums[i] {
                stack.pop();
            }
            if !stack.is_empty() {
                right_next_greater_or_equal[i] = *stack.last().unwrap() as isize;
            }
            stack.push(i);
        }
        stack.clear();

        // Calculate left_prev_smaller_or_equal: index of previous element smaller than or equal to nums[i]
        for i in 0..n {
            while !stack.is_empty() && nums[*stack.last().unwrap()] > nums[i] {
                stack.pop();
            }
            if !stack.is_empty() {
                left_prev_smaller_or_equal[i] = *stack.last().unwrap() as isize;
            }
            stack.push(i);
        }
        stack.clear();

        // Calculate right_next_smaller: index of next element strictly smaller than nums[i]
        for i in (0..n).rev() {
            while !stack.is_empty() && nums[*stack.last().unwrap()] >= nums[i] {
                stack.pop();
            }
            if !stack.is_empty() {
                right_next_smaller[i] = *stack.last().unwrap() as isize;
            }
            stack.push(i);
        }

        let mut sum_of_maximums: i64 = 0;
        let mut sum_of_minimums: i64 = 0;

        for i in 0..n {
            let num = nums[i] as i64;

            // Contribution to sum of maximums
            // Number of subarrays for which nums[i] is the maximum:
            // (i - left_prev_greater[i]) * (right_next_greater_or_equal[i] - i)
            let left_count_max = i as i64 - left_prev_greater[i] as i64;
            let right_count_max = right_next_greater_or_equal[i] as i64 - i as i64;
            sum_of_maximums += num * left_count_max * right_count_max;

            // Contribution to sum of minimums
            // Number of subarrays for which nums[i] is the minimum:
            // (i - left_prev_smaller_or_equal[i]) * (right_next_smaller[i] - i)
            let left_count_min = i as i64 - left_prev_smaller_or_equal[i] as i64;
            let right_count_min = right_next_smaller[i] as i64 - i as i64;
            sum_of_minimums += num * left_count_min * right_count_min;
        }

        sum_of_maximums - sum_of_minimums
    }
}
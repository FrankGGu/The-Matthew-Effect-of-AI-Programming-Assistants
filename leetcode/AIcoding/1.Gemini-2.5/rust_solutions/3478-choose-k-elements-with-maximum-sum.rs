impl Solution {
    pub fn max_sum(nums: Vec<i32>, k: i32) -> i32 {
        let mut max_val = 0;
        for &num in nums.iter() {
            if num > max_val {
                max_val = num;
            }
        }

        // According to the problem "Choose K Elements With Maximum Sum" (LeetCode 2652),
        // the operation is to choose the maximum element, add it to the sum,
        // and then replace it with (max_element + 1). This is repeated k times.
        // This means we always pick the current maximum element.
        // So, we find the initial maximum, and then for k iterations, we add
        // (max_val + i) to the total sum.

        let mut total_sum = 0;
        for i in 0..k {
            total_sum += max_val + i;
        }

        total_sum
    }
}
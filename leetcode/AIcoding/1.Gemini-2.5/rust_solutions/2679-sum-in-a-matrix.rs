impl Solution {
    pub fn matrix_sum(mut nums: Vec<Vec<i32>>) -> i32 {
        let m = nums.len();
        let n = nums[0].len();

        for i in 0..m {
            nums[i].sort_unstable();
        }

        let mut total_sum = 0;

        for _ in 0..n {
            let mut current_max_across_rows = 0;
            for i in 0..m {
                if let Some(val) = nums[i].pop() {
                    current_max_across_rows = current_max_across_rows.max(val);
                }
            }
            total_sum += current_max_across_rows;
        }

        total_sum
    }
}
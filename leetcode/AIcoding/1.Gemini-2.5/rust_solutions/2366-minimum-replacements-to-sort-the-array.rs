impl Solution {
    pub fn minimum_replacements(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut replacements: i64 = 0;
        let mut current_max: i64 = nums[n - 1] as i64;

        for i in (0..n - 1).rev() {
            let num = nums[i] as i64;
            if num > current_max {
                let num_parts = (num + current_max - 1) / current_max;
                replacements += num_parts - 1;
                current_max = num / num_parts;
            } else {
                current_max = num;
            }
        }

        replacements
    }
}
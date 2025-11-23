impl Solution {
    pub fn find_non_min_or_max(nums: Vec<i32>) -> i32 {
        let mut min = i32::MAX;
        let mut max = i32::MIN;

        for &num in &nums {
            if num < min {
                min = num;
            }
            if num > max {
                max = num;
            }
        }

        for &num in &nums {
            if num != min && num != max {
                return num;
            }
        }

        -1
    }
}
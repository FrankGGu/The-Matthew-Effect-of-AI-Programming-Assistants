impl Solution {
    pub fn find_max_positive(nums: Vec<i32>) -> i32 {
        let mut set = std::collections::HashSet::new();
        let mut max_num = 0;

        for &num in &nums {
            if num > 0 {
                set.insert(num);
            }
        }

        for &num in &nums {
            if num < 0 && set.contains(&(-num)) {
                max_num = max_num.max(-num);
            }
        }

        max_num
    }
}
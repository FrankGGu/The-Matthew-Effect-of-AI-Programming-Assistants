impl Solution {
    pub fn find_final_value(nums: Vec<i32>, original: i32) -> i32 {
        let mut current = original;
        let mut nums_set: std::collections::HashSet<i32> = nums.into_iter().collect();

        while nums_set.contains(&current) {
            current *= 2;
        }

        current
    }
}
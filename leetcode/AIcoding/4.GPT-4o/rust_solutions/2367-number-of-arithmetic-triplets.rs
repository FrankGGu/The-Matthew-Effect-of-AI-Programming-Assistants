impl Solution {
    pub fn count_arithmetic_triplets(nums: Vec<i32>, diff: i32) -> i32 {
        let mut count = 0;
        let num_set: std::collections::HashSet<i32> = nums.iter().cloned().collect();

        for &num in &nums {
            if num_set.contains(&(num + diff)) && num_set.contains(&(num + 2 * diff)) {
                count += 1;
            }
        }

        count
    }
}
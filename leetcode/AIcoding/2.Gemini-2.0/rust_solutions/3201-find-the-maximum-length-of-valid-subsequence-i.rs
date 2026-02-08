impl Solution {
    pub fn get_max_len(nums: Vec<i32>, ban: Vec<i32>) -> i32 {
        let ban_set: std::collections::HashSet<i32> = ban.into_iter().collect();
        let mut count = 0;
        for num in nums {
            if !ban_set.contains(&num) {
                count += 1;
            }
        }
        count
    }
}
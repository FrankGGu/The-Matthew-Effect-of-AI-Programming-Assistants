impl Solution {
    pub fn count_triplets(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = nums.len();
        let mut freq = std::collections::HashMap::new();

        for &x in &nums {
            for &y in &nums {
                *freq.entry(x & y).or_insert(0) += 1;
            }
        }

        for &z in &nums {
            for (&xy, &cnt) in &freq {
                if xy & z == 0 {
                    count += cnt;
                }
            }
        }

        count
    }
}
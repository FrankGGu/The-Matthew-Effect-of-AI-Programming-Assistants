impl Solution {
    pub fn sum_counts(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut ans = 0;
        for i in 0..n {
            for j in i..n {
                let mut set = std::collections::HashSet::new();
                for k in i..=j {
                    set.insert(nums[k]);
                }
                let count = set.len() as i32;
                ans += count * count;
            }
        }
        ans
    }
}
impl Solution {
    pub fn min_impossible_or(nums: Vec<i32>) -> i32 {
        let mut s = std::collections::HashSet::new();
        for &num in &nums {
            s.insert(num);
        }

        let mut ans = 1;
        while s.contains(&ans) {
            ans *= 2;
        }

        ans
    }
}
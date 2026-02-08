use std::collections::HashSet;

impl Solution {
    pub fn count_distinct_integers(nums: Vec<i32>) -> i32 {
        let mut s: HashSet<i32> = HashSet::new();
        for &num in &nums {
            s.insert(num);
            let mut reversed = 0;
            let mut n = num;
            while n > 0 {
                reversed = reversed * 10 + n % 10;
                n /= 10;
            }
            s.insert(reversed);
        }
        s.len() as i32
    }
}
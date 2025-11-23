struct Solution;

impl Solution {
    pub fn max_consecutive(n: i32, special: Vec<i32>) -> i32 {
        let mut special = special;
        special.sort();
        let mut max = 0;
        let mut prev = 0;
        for &s in &special {
            max = max.max(s - prev - 1);
            prev = s;
        }
        max = max.max(n - prev);
        max
    }
}
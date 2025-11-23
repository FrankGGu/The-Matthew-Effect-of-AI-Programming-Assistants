struct Solution;

impl Solution {
    pub fn get_last_moment(n: i32, left: Vec<i32>, right: Vec<i32>) -> i32 {
        let mut max_left = 0;
        for &pos in &left {
            max_left = max_left.max(pos);
        }
        let mut min_right = n;
        for &pos in &right {
            min_right = min_right.min(pos);
        }
        max_left.max(n - min_right)
    }
}
impl Solution {
    pub fn get_last_moment(n: i32, left: Vec<i32>, right: Vec<i32>) -> i32 {
        let mut max_left = 0;
        for &l in &left {
            max_left = max_left.max(l);
        }

        let mut max_right = 0;
        for &r in &right {
            max_right = max_right.max(n - r);
        }

        max_left.max(max_right)
    }
}
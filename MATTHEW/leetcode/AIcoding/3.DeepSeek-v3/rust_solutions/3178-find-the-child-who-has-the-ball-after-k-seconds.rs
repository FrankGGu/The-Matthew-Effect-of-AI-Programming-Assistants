impl Solution {
    pub fn number_of_child(n: i32, k: i32) -> i32 {
        let mut pos = 0;
        let mut dir = 1;
        for _ in 0..k {
            pos += dir;
            if pos == 0 || pos == n - 1 {
                dir *= -1;
            }
        }
        pos
    }
}
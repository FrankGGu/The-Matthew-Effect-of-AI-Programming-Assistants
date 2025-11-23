impl Solution {
    pub fn max_jump(stones: Vec<i32>) -> i32 {
        let n = stonest.len();
        if n == 2 {
            return stonest[1] - stonest[0];
        }
        let mut max_jump = 0;
        for i in 0..n - 2 {
            let jump = stonest[i + 2] - stonest[i];
            if jump > max_jump {
                max_jump = jump;
            }
        }
        max_jump
    }
}
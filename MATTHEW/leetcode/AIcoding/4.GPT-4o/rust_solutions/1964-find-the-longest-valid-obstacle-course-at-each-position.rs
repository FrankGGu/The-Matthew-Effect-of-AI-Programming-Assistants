impl Solution {
    pub fn longest_obstacle_course_at_each_position(obstacles: Vec<i32>) -> Vec<i32> {
        let n = obstacles.len();
        let mut dp = vec![0; n];
        let mut lis = vec![];

        for i in 0..n {
            let pos = lis.binary_search(&(obstacles[i] + 1)).unwrap_or_else(|x| x);
            if pos < lis.len() {
                lis[pos] = obstacles[i];
            } else {
                lis.push(obstacles[i]);
            }
            dp[i] = (pos + 1) as i32;
        }

        dp
    }
}
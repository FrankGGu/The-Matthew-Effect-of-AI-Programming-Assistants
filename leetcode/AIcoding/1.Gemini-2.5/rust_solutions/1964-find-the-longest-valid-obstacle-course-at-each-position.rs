impl Solution {
    pub fn longest_obstacle_course_at_each_position(obstacles: Vec<i32>) -> Vec<i32> {
        let mut tails: Vec<i32> = Vec::new();
        let mut ans: Vec<i32> = Vec::new();

        for obstacle in obstacles {
            let idx = tails.partition_point(|&x| x <= obstacle);

            if idx == tails.len() {
                tails.push(obstacle);
            } else {
                tails[idx] = obstacle;
            }
            ans.push((idx + 1) as i32);
        }

        ans
    }
}
impl Solution {
    pub fn longest_obstacle_course_at_each_position(obstacles: Vec<i32>) -> Vec<i32> {
        let n = obstacles.len();
        let mut tail = Vec::new();
        let mut result = Vec::with_capacity(n);

        for &obstacle in &obstacles {
            let i = tail.binary_search(&obstacle).unwrap_or_else(|x| x);
            if i == tail.len() {
                tail.push(obstacle);
            } else {
                tail[i] = obstacle;
            }
            result.push(i as i32 + 1);
        }

        result
    }
}
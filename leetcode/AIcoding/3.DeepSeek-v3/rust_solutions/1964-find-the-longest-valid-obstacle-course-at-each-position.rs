impl Solution {
    pub fn longest_obstacle_course_at_each_position(obstacles: Vec<i32>) -> Vec<i32> {
        let mut tails = Vec::new();
        let mut res = Vec::with_capacity(obstacles.len());

        for &num in obstacles.iter() {
            let idx = tails.partition_point(|&x| x <= num);
            if idx == tails.len() {
                tails.push(num);
            } else {
                tails[idx] = num;
            }
            res.push((idx + 1) as i32);
        }

        res
    }
}
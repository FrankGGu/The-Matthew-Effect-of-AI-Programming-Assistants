impl Solution {
    pub fn get_collision_times(cars: Vec<Vec<i32>>) -> Vec<f64> {
        let n = cars.len();
        let mut stack: Vec<usize> = Vec::new();
        let mut res = vec![-1.0; n];

        for i in (0..n).rev() {
            let (pos_i, speed_i) = (cars[i][0], cars[i][1]);

            while !stack.is_empty() {
                let j = *stack.last().unwrap();
                let (pos_j, speed_j) = (cars[j][0], cars[j][1]);

                if speed_i <= speed_j {
                    stack.pop();
                } else {
                    let collision_time = (pos_j - pos_i) as f64 / (speed_i - speed_j) as f64;
                    if collision_time <= res[j] || res[j] < 0.0 {
                        res[i] = collision_time;
                        break;
                    } else {
                        stack.pop();
                    }
                }
            }
            stack.push(i);
        }
        res
    }
}
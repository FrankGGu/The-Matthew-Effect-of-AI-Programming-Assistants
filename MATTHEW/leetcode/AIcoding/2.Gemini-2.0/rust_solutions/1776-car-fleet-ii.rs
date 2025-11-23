impl Solution {
    pub fn get_collision_times(cars: Vec<Vec<i32>>) -> Vec<f64> {
        let n = cars.len();
        let mut ans = vec![-1.0; n];
        let mut stack: Vec<usize> = Vec::new();

        for i in (0..n).rev() {
            let speed = cars[i][1];
            while let Some(&j) = stack.last() {
                if cars[j][1] >= speed {
                    stack.pop();
                } else {
                    let pos_diff = cars[j][0] - cars[i][0];
                    let speed_diff = speed - cars[j][1];
                    let collision_time = pos_diff as f64 / speed_diff as f64;
                    if ans[j] == -1.0 || collision_time <= ans[j] {
                        break;
                    } else {
                        stack.pop();
                    }
                }
            }

            if let Some(&j) = stack.last() {
                let pos_diff = cars[j][0] - cars[i][0];
                let speed_diff = speed - cars[j][1];
                ans[i] = pos_diff as f64 / speed_diff as f64;
            }

            stack.push(i);
        }

        ans
    }
}
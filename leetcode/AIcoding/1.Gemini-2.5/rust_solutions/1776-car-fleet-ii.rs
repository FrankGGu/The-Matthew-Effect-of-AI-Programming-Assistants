struct Solution;

impl Solution {
    pub fn get_collision_times(cars: Vec<Vec<i32>>) -> Vec<f64> {
        let n = cars.len();
        let mut ans = vec![-1.0; n];
        let mut stack: Vec<usize> = Vec::new(); // Stores indices of cars

        for i in (0..n).rev() {
            let pos_i = cars[i][0] as f64;
            let speed_i = cars[i][1] as f64;

            while let Some(&j) = stack.last() {
                let pos_j = cars[j][0] as f64;
                let speed_j = cars[j][1] as f64;

                if speed_i <= speed_j {
                    // Car i is slower or same speed as car j. It will never catch j.
                    // So j cannot be the car i collides with. Pop j.
                    stack.pop();
                } else {
                    // Car i is faster than car j. It could collide with j.
                    let time_to_collide_ij = (pos_j - pos_i) / (speed_i - speed_j);

                    if ans[j] == -1.0 {
                        // Car j never collides with any car further right.
                        // So, car i will collide with car j.
                        ans[i] = time_to_collide_ij;
                        break; // Found the first collision for car i.
                    } else if time_to_collide_ij <= ans[j] {
                        // Car i collides with car j before or at the same time car j collides with k.
                        // So, car i will collide with car j.
                        ans[i] = time_to_collide_ij;
                        break; // Found the first collision for car i.
                    } else {
                        // Car j collides with car k (or fleet j-k) before car i collides with j.
                        // This means car i will never collide with car j as an individual car.
                        // Instead, car i will collide with the fleet formed by j and k.
                        // So, j is not the direct target for i. Pop j and check the next car on the stack.
                        stack.pop();
                    }
                }
            }
            stack.push(i);
        }

        ans
    }
}
impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn robot_sim(queries: Vec<Vec<i32>>, n: i32) -> Vec<i32> {
        let mut blocked = HashSet::new();
        for q in &queries {
            blocked.insert((q[0], q[1]));
        }

        let mut result = vec![0; n as usize];
        let mut x = 0;
        let mut y = 0;
        let mut dx = 0;
        let mut dy = 1;

        for i in 0..n {
            let mut steps = i + 1;
            while steps > 0 {
                let next_x = x + dx;
                let next_y = y + dy;
                if blocked.contains(&(next_x, next_y)) {
                    break;
                }
                x = next_x;
                y = next_y;
                steps -= 1;
            }
            result[i as usize] = x * 100000 + y;
            let temp = dx;
            dx = -dy;
            dy = temp;
        }

        result
    }
}
}
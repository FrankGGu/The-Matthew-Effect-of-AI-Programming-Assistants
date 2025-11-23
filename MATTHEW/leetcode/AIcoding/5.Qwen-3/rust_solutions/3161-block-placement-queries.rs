impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn possible_to_place(queries: Vec<Vec<i32>>, n: i32) -> Vec<bool> {
        let mut result = Vec::new();
        let mut occupied = HashMap::new();
        let mut used = HashMap::new();

        for q in queries {
            let x = q[0];
            let y = q[1];
            let k = q[2];

            let mut placed = false;
            let mut dx = 0;
            while dx <= k {
                let dy = 0;
                if !occupied.contains_key(&(x + dx, y + dy)) && !occupied.contains_key(&(x + dx, y - dy)) {
                    let mut valid = true;
                    for i in 0..k {
                        if occupied.contains_key(&(x + dx + i, y + dy)) || occupied.contains_key(&(x + dx + i, y - dy)) {
                            valid = false;
                            break;
                        }
                    }
                    if valid {
                        placed = true;
                        for i in 0..k {
                            occupied.insert((x + dx + i, y + dy), true);
                            occupied.insert((x + dx + i, y - dy), true);
                        }
                        break;
                    }
                }
                dx += 1;
            }
            result.push(placed);
        }

        result
    }
}
}
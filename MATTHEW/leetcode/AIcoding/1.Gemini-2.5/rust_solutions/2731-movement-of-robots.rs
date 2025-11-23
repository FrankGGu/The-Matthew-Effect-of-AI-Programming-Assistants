use std::collections::HashMap;

impl Solution {
    pub fn count_collisions(base_pos: Vec<i32>, d: String, t: i32) -> i64 {
        let n = base_pos.len();
        let mut final_positions: Vec<i32> = Vec::with_capacity(n);
        let directions: Vec<char> = d.chars().collect();

        for i in 0..n {
            let pos = base_pos[i];
            let dir = directions[i];
            if dir == 'L' {
                final_positions.push(pos - t);
            } else { // dir == 'R'
                final_positions.push(pos + t);
            }
        }

        let mut counts: HashMap<i32, i64> = HashMap::new();
        for &pos in final_positions.iter() {
            *counts.entry(pos).or_insert(0) += 1;
        }

        let mut total_collisions: i64 = 0;
        for (_pos, count) in counts.iter() {
            if count > 1 {
                total_collisions += count * (count - 1) / 2;
            }
        }

        total_collisions
    }
}
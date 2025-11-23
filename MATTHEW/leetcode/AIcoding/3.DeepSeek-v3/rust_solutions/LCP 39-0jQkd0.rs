use std::collections::HashMap;

impl Solution {
    pub fn min_drone_moves(target: Vec<Vec<i32>>, initial: Vec<Vec<i32>>) -> i32 {
        let mut target_map = HashMap::new();
        let mut initial_map = HashMap::new();

        for pos in target {
            *target_map.entry((pos[0], pos[1])).or_insert(0) += 1;
        }

        for pos in initial {
            *initial_map.entry((pos[0], pos[1])).or_insert(0) += 1;
        }

        let mut moves = 0;

        for (key, &count) in target_map.iter() {
            let initial_count = initial_map.get(key).unwrap_or(&0);
            if count > *initial_count {
                moves += count - initial_count;
            }
        }

        moves
    }
}
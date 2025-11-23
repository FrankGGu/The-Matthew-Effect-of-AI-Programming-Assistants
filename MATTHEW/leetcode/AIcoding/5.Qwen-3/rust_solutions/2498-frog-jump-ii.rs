struct Solution;

impl Solution {
    pub fn can_cross(stones: Vec<i32>) -> bool {
        use std::collections::{HashMap, HashSet};

        if stones[0] != 0 {
            return false;
        }

        let mut map = HashMap::new();
        for &stone in &stones {
            map.insert(stone, HashSet::new());
        }

        map.get_mut(&0).unwrap().insert(0);

        for &stone in &stones {
            if let Some(jumps) = map.get_mut(&stone) {
                for &jump in jumps {
                    for k in [jump - 1, jump, jump + 1] {
                        if k > 0 {
                            let next = stone + k;
                            if let Some(next_jumps) = map.get_mut(&next) {
                                next_jumps.insert(k);
                            }
                        }
                    }
                }
            }
        }

        !map.get(&stones[stones.len() - 1]).unwrap().is_empty()
    }
}
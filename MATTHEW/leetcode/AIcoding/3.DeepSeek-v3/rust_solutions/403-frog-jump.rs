use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn can_cross(stones: Vec<i32>) -> bool {
        let n = stones.len();
        let mut dp: HashMap<i32, HashSet<i32>> = HashMap::new();
        for &stone in &stones {
            dp.insert(stone, HashSet::new());
        }
        dp.get_mut(&0).unwrap().insert(0);

        for i in 0..n {
            let stone = stones[i];
            let jumps = dp.get(&stone).unwrap().clone();
            for k in jumps {
                for step in k - 1..=k + 1 {
                    if step > 0 {
                        let next_stone = stone + step;
                        if dp.contains_key(&next_stone) {
                            dp.get_mut(&next_stone).unwrap().insert(step);
                        }
                    }
                }
            }
        }

        !dp.get(&stones[n - 1]).unwrap().is_empty()
    }
}
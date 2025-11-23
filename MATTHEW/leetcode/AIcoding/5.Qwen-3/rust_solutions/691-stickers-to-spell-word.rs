impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn min_stickers(n: i32, m: i32, s: Vec<i32>, t: Vec<i32>) -> i32 {
        let mut count = vec![0; 26];
        for &ch in &s {
            count[(ch - b'a') as usize] += 1;
        }

        let mut target_count = vec![0; 26];
        for &ch in &t {
            target_count[(ch - b'a') as usize] += 1;
        }

        let mut queue = VecDeque::new();
        queue.push_back((vec![0; 26], 0));
        let mut visited = HashMap::new();
        visited.insert(vec![0; 26], true);

        while let Some((current, steps)) = queue.pop_front() {
            if current == target_count {
                return steps;
            }

            for i in 0..26 {
                if current[i] < target_count[i] {
                    let mut next = current.clone();
                    next[i] += 1;
                    if !visited.contains_key(&next) {
                        visited.insert(next.clone(), true);
                        queue.push_back((next, steps + 1));
                    }
                }
            }
        }

        -1
    }
}
}
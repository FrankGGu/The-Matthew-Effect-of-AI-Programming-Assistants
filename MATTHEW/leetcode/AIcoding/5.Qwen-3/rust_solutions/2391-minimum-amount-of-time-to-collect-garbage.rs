impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn garbage_collection(garbage: Vec<String>, travel: Vec<i32>) -> i32 {
        let mut time = 0;
        let mut last_pos = vec![0; 3];

        for (i, s) in garbage.iter().enumerate() {
            for c in s.chars() {
                time += 1;
                match c {
                    'G' => last_pos[0] = i,
                    'P' => last_pos[1] = i,
                    'M' => last_pos[2] = i,
                    _ => {}
                }
            }
        }

        for i in 0..3 {
            for j in 0..last_pos[i] {
                time += travel[j];
            }
        }

        time
    }
}
}
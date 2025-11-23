impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn max_groups(how_many: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut count = vec![0; k];
        for &num in &how_many {
            count[(num as usize) % k] += 1;
        }

        let mut groups = 0;
        let mut seen = HashSet::new();

        for i in 0..k {
            if count[i] == 0 {
                continue;
            }
            let mut current = i;
            let mut visited = HashSet::new();
            while !visited.contains(&current) {
                visited.insert(current);
                if count[current] > 0 {
                    count[current] -= 1;
                    groups += 1;
                }
                current = (current + 1) % k;
            }
        }

        groups
    }
}
}
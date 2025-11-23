impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_number_of_frogs_croaking(s: String) -> i32 {
        let mut count = HashMap::new();
        let mut max_frog = 0;
        let mut current_frog = 0;

        for c in s.chars() {
            match c {
                'c' => {
                    *count.entry('c').or_insert(0) += 1;
                    current_frog += 1;
                    max_frog = std::cmp::max(max_frog, current_frog);
                },
                'r' => {
                    *count.entry('r').or_insert(0) += 1;
                    if *count.get(&'c').unwrap() < *count.get(&'r').unwrap() {
                        return -1;
                    }
                },
                'o' => {
                    *count.entry('o').or_insert(0) += 1;
                    if *count.get(&'r').unwrap() < *count.get(&'o').unwrap() {
                        return -1;
                    }
                },
                'a' => {
                    *count.entry('a').or_insert(0) += 1;
                    if *count.get(&'o').unwrap() < *count.get(&'a').unwrap() {
                        return -1;
                    }
                },
                'k' => {
                    *count.entry('k').or_insert(0) += 1;
                    if *count.get(&'a').unwrap() < *count.get(&'k').unwrap() {
                        return -1;
                    }
                    current_frog -= 1;
                },
                _ => return -1,
            }
        }

        if *count.get(&'c').unwrap() != *count.get(&'k').unwrap() {
            return -1;
        }

        max_frog
    }
}
}
impl Solution {

use std::collections::{HashSet, HashMap};

fn main() {
    // This is just to satisfy the module structure; LeetCode will not call this directly.
}

pub fn unhappy_friends(n: i32, preferences: Vec<Vec<i32>>, pairs: Vec<Vec<i32>>) -> i32 {
    let mut pair_map = HashMap::new();
    for pair in &pairs {
        let a = pair[0];
        let b = pair[1];
        pair_map.insert(a, b);
        pair_map.insert(b, a);
    }

    let mut unhappy = HashSet::new();

    for pair in &pairs {
        let a = pair[0];
        let b = pair[1];

        for &friend in &preferences[a as usize] {
            if friend == b {
                break;
            }
            if pair_map.get(&friend).unwrap() != &a {
                unhappy.insert(a);
                break;
            }
        }

        for &friend in &preferences[b as usize] {
            if friend == a {
                break;
            }
            if pair_map.get(&friend).unwrap() != &b {
                unhappy.insert(b);
                break;
            }
        }
    }

    unhappy.len() as i32
}
}
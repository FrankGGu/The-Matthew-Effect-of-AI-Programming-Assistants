use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn min_stickers(stickers: Vec<String>, target: String) -> i32 {
        let target_chars: Vec<char> = target.chars().collect();
        let mut target_counts = [0; 26];
        for &c in &target_chars {
            target_counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut sticker_counts = Vec::new();
        for sticker in stickers {
            let mut counts = [0; 26];
            for c in sticker.chars() {
                counts[(c as u8 - b'a') as usize] += 1;
            }
            sticker_counts.push(counts);
        }

        let mut queue = VecDeque::new();
        queue.push_back(target_counts.clone());
        let mut visited = HashSet::new();
        visited.insert(target_counts);
        let mut steps = 0;

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let current = queue.pop_front().unwrap();
                if current.iter().all(|&x| x == 0) {
                    return steps;
                }

                for sticker in &sticker_counts {
                    let mut next = current.clone();
                    for i in 0..26 {
                        if sticker[i] > 0 && next[i] > 0 {
                            next[i] -= std::cmp::min(sticker[i], next[i]);
                        }
                    }

                    if !visited.contains(&next) {
                        visited.insert(next.clone());
                        queue.push_back(next);
                    }
                }
            }
            steps += 1;
        }

        -1
    }
}
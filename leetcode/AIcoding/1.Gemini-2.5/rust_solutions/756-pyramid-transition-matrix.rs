use std::collections::{HashMap, HashSet};

struct Solution;

impl Solution {
    pub fn pyramid_transition(bottom: String, allowed: Vec<String>) -> bool {
        let mut transitions: HashMap<(u8, u8), Vec<u8>> = HashMap::new();
        for rule in allowed {
            let chars: Vec<u8> = rule.chars().map(|c| (c as u8 - b'A')).collect();
            transitions.entry((chars[0], chars[1])).or_insert_with(Vec::new).push(chars[2]);
        }

        let mut memo: HashSet<Vec<u8>> = HashSet::new();

        let initial_level: Vec<u8> = bottom.chars().map(|c| (c as u8 - b'A')).collect();

        Self::dfs(initial_level, &transitions, &mut memo)
    }

    fn dfs(
        current_level: Vec<u8>,
        transitions: &HashMap<(u8, u8), Vec<u8>>,
        memo: &mut HashSet<Vec<u8>>,
    ) -> bool {
        if current_level.len() == 1 {
            return true;
        }

        if memo.contains(&current_level) {
            return false;
        }

        let mut next_level_buffer: Vec<u8> = Vec::with_capacity(current_level.len() - 1);

        if Self::build_next_level(
            0,
            &current_level,
            &mut next_level_buffer,
            transitions,
            memo,
        ) {
            true
        } else {
            memo.insert(current_level);
            false
        }
    }

    fn build_next_level(
        idx: usize,
        current_level: &[u8],
        next_level_buffer: &mut Vec<u8>,
        transitions: &HashMap<(u8, u8), Vec<u8>>,
        memo: &mut HashSet<Vec<u8>>,
    ) -> bool {
        if idx == current_level.len() - 1 {
            return Self::dfs(next_level_buffer.clone(), transitions, memo);
        }

        let left = current_level[idx];
        let right = current_level[idx + 1];

        if let Some(possible_tops) = transitions.get(&(left, right)) {
            for &top_char in possible_tops {
                next_level_buffer.push(top_char);

                if Self::build_next_level(
                    idx + 1,
                    current_level,
                    next_level_buffer,
                    transitions,
                    memo,
                ) {
                    return true;
                }

                next_level_buffer.pop();
            }
        }

        false
    }
}
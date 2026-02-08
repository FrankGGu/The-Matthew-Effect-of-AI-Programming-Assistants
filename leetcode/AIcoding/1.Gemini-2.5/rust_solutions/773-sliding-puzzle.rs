use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn sliding_puzzle(board: Vec<Vec<i32>>) -> i32 {
        let target = "123450";
        let mut initial_state_vec: Vec<char> = Vec::with_capacity(6);
        for r in 0..2 {
            for c in 0..3 {
                initial_state_vec.push(std::char::from_digit(board[r][c] as u32, 10).unwrap());
            }
        }
        let initial_state: String = initial_state_vec.into_iter().collect();

        let mut queue: VecDeque<(String, i32)> = VecDeque::new();
        let mut visited: HashSet<String> = HashSet::new();

        queue.push_back((initial_state.clone(), 0));
        visited.insert(initial_state);

        // Predefined swap positions for each index of the flattened 2x3 board
        // Indices:
        // 0 1 2
        // 3 4 5
        let swaps: [Vec<usize>; 6] = [
            vec![1, 3],     // For index 0
            vec![0, 2, 4],  // For index 1
            vec![1, 5],     // For index 2
            vec![0, 4],     // For index 3
            vec![1, 3, 5],  // For index 4
            vec![2, 4],     // For index 5
        ];

        while let Some((current_state, moves)) = queue.pop_front() {
            if current_state == target {
                return moves;
            }

            let zero_idx = current_state.find('0').unwrap();
            let current_chars: Vec<char> = current_state.chars().collect();

            for &swap_idx in swaps[zero_idx].iter() {
                let mut next_chars = current_chars.clone();
                next_chars.swap(zero_idx, swap_idx);
                let next_state: String = next_chars.into_iter().collect();

                if visited.insert(next_state.clone()) {
                    queue.push_back((next_state, moves + 1));
                }
            }
        }

        -1
    }
}
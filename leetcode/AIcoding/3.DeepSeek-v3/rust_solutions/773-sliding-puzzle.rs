use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn sliding_puzzle(board: Vec<Vec<i32>>) -> i32 {
        let target = vec![1, 2, 3, 4, 5, 0];
        let moves = vec![
            vec![1, 3],
            vec![0, 2, 4],
            vec![1, 5],
            vec![0, 4],
            vec![1, 3, 5],
            vec![2, 4],
        ];

        let mut initial = Vec::new();
        for row in board {
            for num in row {
                initial.push(num);
            }
        }

        if initial == target {
            return 0;
        }

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((initial.clone(), 0));
        visited.insert(initial);

        while let Some((state, steps)) = queue.pop_front() {
            let zero_pos = state.iter().position(|&x| x == 0).unwrap();
            for &next_pos in &moves[zero_pos] {
                let mut new_state = state.clone();
                new_state.swap(zero_pos, next_pos);
                if new_state == target {
                    return steps + 1;
                }
                if !visited.contains(&new_state) {
                    visited.insert(new_state.clone());
                    queue.push_back((new_state, steps + 1));
                }
            }
        }

        -1
    }
}
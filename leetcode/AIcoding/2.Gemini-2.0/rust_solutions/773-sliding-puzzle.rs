use std::collections::VecDeque;
use std::collections::HashSet;

impl Solution {
    pub fn sliding_puzzle(board: Vec<Vec<i32>>) -> i32 {
        let target = "123450";
        let initial = board.iter().flatten().map(|&x| x.to_string()).collect::<String>();

        let mut queue = VecDeque::new();
        queue.push_back((initial.clone(), 0));

        let mut visited = HashSet::new();
        visited.insert(initial.clone());

        let neighbors = vec![
            vec![1, 3],
            vec![0, 2, 4],
            vec![1, 5],
            vec![0, 4],
            vec![1, 3, 5],
            vec![2, 4],
        ];

        while let Some((current, steps)) = queue.pop_front() {
            if current == target {
                return steps;
            }

            let zero_index = current.find('0').unwrap() as usize;

            for &neighbor in &neighbors[zero_index] {
                let mut next = current.clone();
                let mut chars: Vec<char> = next.chars().collect();
                chars.swap(zero_index, neighbor);
                next = chars.into_iter().collect();

                if !visited.contains(&next) {
                    queue.push_back((next.clone(), steps + 1));
                    visited.insert(next);
                }
            }
        }

        -1
    }
}
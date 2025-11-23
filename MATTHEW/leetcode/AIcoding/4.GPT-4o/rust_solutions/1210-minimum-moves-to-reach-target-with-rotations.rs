use std::collections::HashSet;
use std::collections::VecDeque;

pub fn minimum_moves(target: i32) -> i32 {
    let target = target.abs();
    let mut visited = HashSet::new();
    let mut queue = VecDeque::new();
    queue.push_back((0, 0)); // (position, moves)
    visited.insert((0, 0));

    while let Some((pos, moves)) = queue.pop_front() {
        if pos == target {
            return moves;
        }

        let new_moves = moves + 1;
        let next_positions = vec![pos + new_moves, pos - new_moves, pos * 2];

        for &next_pos in &next_positions {
            if next_pos >= 0 && !visited.contains(&(next_pos, new_moves)) {
                visited.insert((next_pos, new_moves));
                queue.push_back((next_pos, new_moves));
            }
        }
    }

    -1
}
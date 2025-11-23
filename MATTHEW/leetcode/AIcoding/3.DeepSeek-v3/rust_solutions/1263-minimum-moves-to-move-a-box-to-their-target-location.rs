use std::collections::{VecDeque, HashSet};

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct State {
    box_pos: (i32, i32),
    player_pos: (i32, i32),
}

impl State {
    fn new(box_pos: (i32, i32), player_pos: (i32, i32)) -> Self {
        State { box_pos, player_pos }
    }
}

pub fn min_push_box(grid: Vec<Vec<char>>) -> i32 {
    let (rows, cols) = (grid.len() as i32, grid[0].len() as i32);
    let mut start_box = (0, 0);
    let mut start_player = (0, 0);
    let mut target = (0, 0);

    for i in 0..rows {
        for j in 0..cols {
            match grid[i as usize][j as usize] {
                'B' => start_box = (i, j),
                'S' => start_player = (i, j),
                'T' => target = (i, j),
                _ => (),
            }
        }
    }

    let dirs = vec![(-1, 0), (1, 0), (0, -1), (0, 1)];
    let mut queue = VecDeque::new();
    let mut visited = HashSet::new();
    let initial_state = State::new(start_box, start_player);
    queue.push_back((initial_state, 0));
    visited.insert(initial_state);

    while let Some((state, moves)) = queue.pop_front() {
        if state.box_pos == target {
            return moves;
        }

        for &(di, dj) in &dirs {
            let new_player_pos = (state.player_pos.0 + di, state.player_pos.1 + dj);
            if new_player_pos.0 < 0 || new_player_pos.0 >= rows || new_player_pos.1 < 0 || new_player_pos.1 >= cols {
                continue;
            }
            if grid[new_player_pos.0 as usize][new_player_pos.1 as usize] == '#' {
                continue;
            }

            if new_player_pos == state.box_pos {
                let new_box_pos = (state.box_pos.0 + di, state.box_pos.1 + dj);
                if new_box_pos.0 < 0 || new_box_pos.0 >= rows || new_box_pos.1 < 0 || new_box_pos.1 >= cols {
                    continue;
                }
                if grid[new_box_pos.0 as usize][new_box_pos.1 as usize] == '#' {
                    continue;
                }
                let new_state = State::new(new_box_pos, new_player_pos);
                if !visited.contains(&new_state) {
                    visited.insert(new_state);
                    queue.push_back((new_state, moves + 1));
                }
            } else {
                let new_state = State::new(state.box_pos, new_player_pos);
                if !visited.contains(&new_state) {
                    visited.insert(new_state);
                    queue.push_front((new_state, moves));
                }
            }
        }
    }

    -1
}
use std::collections::{VecDeque, HashSet};

const DIRS: [(isize, isize); 4] = [(-1, 0), (1, 0), (0, -1), (0, 1)]; // Up, Down, Left, Right

struct Solution;

impl Solution {
    pub fn min_pushes(grid: Vec<Vec<char>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();

        let mut player_start = (0, 0);
        let mut box_start = (0, 0);
        let mut target = (0, 0);

        for r in 0..rows {
            for c in 0..cols {
                match grid[r][c] {
                    'S' => player_start = (r, c),
                    'B' => box_start = (r, c),
                    'T' => target = (r, c),
                    _ => {}
                }
            }
        }

        // State: (box_r, box_c, player_r, player_c)
        let mut queue: VecDeque<(usize, usize, usize, usize, i32)> = VecDeque::new();
        let mut visited: HashSet<(usize, usize, usize, usize)> = HashSet::new();

        queue.push_back((box_start.0, box_start.1, player_start.0, player_start.1, 0));
        visited.insert((box_start.0, box_start.1, player_start.0, player_start.1));

        while let Some((br, bc, pr, pc, pushes)) = queue.pop_front() {
            if br == target.0 && bc == target.1 {
                return pushes;
            }

            for i in 0..4 {
                let (dr, dc) = DIRS[i];

                // Calculate next box position
                let nbr_isize = br as isize + dr;
                let nbc_isize = bc as isize + dc;

                // Calculate player position needed to push
                let ppr_needed_isize = br as isize - dr;
                let ppc_needed_isize = bc as isize - dc;

                // Check bounds for new box position
                if nbr_isize < 0 || nbr_isize >= rows as isize || nbc_isize < 0 || nbc_isize >= cols as isize {
                    continue;
                }
                let nbr = nbr_isize as usize;
                let nbc = nbc_isize as usize;

                // Check bounds for player position needed to push
                if ppr_needed_isize < 0 || ppr_needed_isize >= rows as isize || ppc_needed_isize < 0 || ppc_needed_isize >= cols as isize {
                    continue;
                }
                let ppr_needed = ppr_needed_isize as usize;
                let ppc_needed = ppc_needed_isize as usize;

                // Check if new box position is a wall
                if grid[nbr][nbc] == '#' {
                    continue;
                }

                // Check if player position needed to push is a wall
                if grid[ppr_needed][ppc_needed] == '#' {
                    continue;
                }

                // Check if player can reach ppr_needed, ppc_needed from pr, pc
                // without passing through the current box position (br, bc)
                if Self::can_player_reach(&grid, rows, cols, pr, pc, ppr_needed, ppc_needed, br, bc) {
                    let next_state = (nbr, nbc, br, bc); // Player moves to where the box was
                    if visited.insert(next_state) {
                        queue.push_back((next_state.0, next_state.1, next_state.2, next_state.3, pushes + 1));
                    }
                }
            }
        }

        -1
    }

    // Helper function to check if player can reach (target_pr, target_pc) from (start_pr, start_pc)
    // avoiding walls and the box at (box_r, box_c).
    fn can_player_reach(
        grid: &Vec<Vec<char>>,
        rows: usize,
        cols: usize,
        start_pr: usize,
        start_pc: usize,
        target_pr: usize,
        target_pc: usize,
        box_r: usize,
        box_c: usize,
    ) -> bool {
        let mut q: VecDeque<(usize, usize)> = VecDeque::new();
        let mut visited_player: HashSet<(usize, usize)> = HashSet::new();

        q.push_back((start_pr, start_pc));
        visited_player.insert((start_pr, start_pc));

        while let Some((curr_pr, curr_pc)) = q.pop_front() {
            if curr_pr == target_pr && curr_pc == target_pc {
                return true;
            }

            for (dr, dc) in DIRS.iter().copied() {
                let npr_isize = curr_pr as isize + dr;
                let npc_isize = curr_pc as isize + dc;

                if npr_isize < 0 || npr_isize >= rows as isize || npc_isize < 0 || npc_isize >= cols as isize {
                    continue;
                }
                let npr = npr_isize as usize;
                let npc = npc_isize as usize;

                if grid[npr][npc] == '#' {
                    continue;
                }

                // Player cannot move into the current box position
                if npr == box_r && npc == box_c {
                    continue;
                }

                if visited_player.insert((npr, npc)) {
                    q.push_back((npr, npc));
                }
            }
        }
        false
    }
}
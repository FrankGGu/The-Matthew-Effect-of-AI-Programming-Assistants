struct Solution;

impl Solution {
    pub fn minimum_moves(grid: Vec<Vec<i32>>) -> i32 {
        let mut sources = Vec::new(); // Stores (r, c) for each extra stone
        let mut destinations = Vec::new(); // Stores (r, c) for each empty cell

        for r in 0..3 {
            for c in 0..3 {
                if grid[r][c] > 1 {
                    // If a cell has more than 1 stone, it has (grid[r][c] - 1) extra stones
                    for _ in 0..(grid[r][c] - 1) {
                        sources.push((r, c));
                    }
                } else if grid[r][c] == 0 {
                    // If a cell has 0 stones, it needs 1 stone
                    destinations.push((r, c));
                }
            }
        }

        // If there are no sources (and thus no destinations, as total stones is 9),
        // all cells already have 1 stone, so 0 moves are needed.
        if sources.is_empty() {
            return 0;
        }

        // The number of extra stones must equal the number of empty cells
        let n = sources.len();
        let mut min_total_moves = std::i32::MAX;
        let mut used_destinations = vec![false; n]; // To track which destination cells are used

        // Recursive helper function to explore all possible assignments
        // k: current index of the source stone being considered
        // current_moves: sum of moves for sources 0 to k-1
        // sources: list of coordinates for extra stones
        // destinations: list of coordinates for empty cells
        // used_destinations: boolean array to mark used destination cells
        // min_total_moves: mutable reference to store the minimum moves found so far
        fn solve(
            k: usize,
            current_moves: i32,
            sources: &Vec<(usize, usize)>,
            destinations: &Vec<(usize, usize)>,
            used_destinations: &mut Vec<bool>,
            min_total_moves: &mut i32,
        ) {
            let n = sources.len();
            if k == n {
                // All sources have been matched to destinations
                *min_total_moves = (*min_total_moves).min(current_moves);
                return;
            }

            // Pruning: if current path already exceeds the minimum found so far, stop
            if current_moves >= *min_total_moves {
                return;
            }

            let (sr, sc) = sources[k]; // Current source stone's coordinates

            // Try to match the current source stone (sources[k]) with an unused destination
            for i in 0..n {
                if !used_destinations[i] {
                    let (dr, dc) = destinations[i]; // Candidate destination's coordinates
                    let moves = (sr as i32 - dr as i32).abs() + (sc as i32 - dc as i32).abs();

                    used_destinations[i] = true; // Mark destination as used
                    solve(
                        k + 1, // Move to the next source stone
                        current_moves + moves, // Add moves for this assignment
                        sources,
                        destinations,
                        used_destinations,
                        min_total_moves,
                    );
                    used_destinations[i] = false; // Backtrack: unmark destination for other permutations
                }
            }
        }

        solve(0, 0, &sources, &destinations, &mut used_destinations, &mut min_total_moves);

        min_total_moves
    }
}
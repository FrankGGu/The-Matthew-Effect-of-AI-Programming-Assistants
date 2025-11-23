struct Solution;

impl Solution {
    pub fn robot_path(commands: String, queries: Vec<Vec<i32>>, target: Vec<i32>) -> Vec<bool> {
        let mut path_coords: Vec<(i32, i32)> = Vec::new();
        path_coords.push((0, 0));

        let mut current_x = 0;
        let mut current_y = 0;

        for command_char in commands.chars() {
            match command_char {
                'R' => current_x += 1,
                'U' => current_y += 1,
                _ => (), // Problem constraints guarantee only 'R' or 'U'
            }
            path_coords.push((current_x, current_y));
        }

        // The final position after one full cycle of commands
        let final_x = path_coords.last().unwrap().0;
        let final_y = path_coords.last().unwrap().1;

        let mut results = Vec::with_capacity(queries.len());

        for query in queries {
            let tx = query[0];
            let ty = query[1];

            let mut is_reachable = false;
            // Iterate through each point (px_i, py_i) in the first cycle of the path
            for &(px_i, py_i) in &path_coords {
                // If the current path point (px_i, py_i) is already beyond the target (tx, ty)
                // in either x or y, then (tx, ty) cannot be reached from this point
                // by moving only R/U and adding non-negative cycles.
                if tx < px_i || ty < py_i {
                    continue;
                }

                // Calculate the remaining distance needed to reach (tx, ty) from (px_i, py_i)
                let dx = tx - px_i;
                let dy = ty - py_i;

                if final_x == 0 && final_y == 0 {
                    // If the robot returns to the origin after one cycle, its path is finite.
                    // It can only reach (tx, ty) if (tx, ty) is exactly (px_i, py_i).
                    if dx == 0 && dy == 0 {
                        is_reachable = true;
                        break;
                    }
                } else if final_x == 0 {
                    // If the robot only moves vertically after the first cycle (final_x is 0).
                    // The x-coordinate must match px_i, and the y-coordinate must be reachable
                    // by some non-negative number of full vertical cycles.
                    if dx == 0 && dy % final_y == 0 {
                        is_reachable = true;
                        break;
                    }
                } else if final_y == 0 {
                    // If the robot only moves horizontally after the first cycle (final_y is 0).
                    // The y-coordinate must match py_i, and the x-coordinate must be reachable
                    // by some non-negative number of full horizontal cycles.
                    if dy == 0 && dx % final_x == 0 {
                        is_reachable = true;
                        break;
                    }
                } else {
                    // If the robot moves both horizontally and vertically after the first cycle.
                    // Both dx and dy must be multiples of final_x and final_y respectively,
                    // and the number of cycles 'k' derived from x and y must be the same.
                    if dx % final_x == 0 && dy % final_y == 0 {
                        let k1 = dx / final_x;
                        let k2 = dy / final_y;
                        if k1 == k2 {
                            is_reachable = true;
                            break;
                        }
                    }
                }
            }
            results.push(is_reachable);
        }

        results
    }
}
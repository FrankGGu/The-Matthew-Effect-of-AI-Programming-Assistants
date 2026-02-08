struct Solution;

impl Solution {
    pub fn solve(m: i32, n: i32, mirrors: Vec<Vec<i32>>, start: Vec<i32>, direction: i32) -> Vec<i32> {
        let mut grid = vec![vec![0; n as usize]; m as usize];

        for mirror in mirrors {
            let r = mirror[0] as usize;
            let c = mirror[1] as usize;
            let t = mirror[2]; // 0 for '\', 1 for '/'
            grid[r][c] = t + 1; // Store 1 for '\', 2 for '/'
        }

        let dx: [i32; 4] = [1, 0, -1, 0]; // 0: right, 1: down, 2: left, 3: up
        let dy: [i32; 4] = [0, 1, 0, -1];

        let mut r = start[0];
        let mut c = start[1];
        let mut d = direction;

        // The ray is considered to be "entering" the starting cell (r, c).
        // So, check for a mirror at the starting cell and reflect if necessary.
        let mirror_type_at_start = grid[r as usize][c as usize];
        if mirror_type_at_start == 1 { // Type 0 mirror ('\')
            d = d ^ 1;
        } else if mirror_type_at_start == 2 { // Type 1 mirror ('/')
            d = 3 - d;
        }

        // Now the ray has potentially reflected at the starting cell, and is ready to move.
        loop {
            // Move one step in the current direction
            r += dy[d as usize];
            c += dx[d as usize];

            // Check if the ray has exited the box
            if r < 0 || r >= m || c < 0 || c >= n {
                return vec![r, c];
            }

            // If still inside, check for a mirror at the new cell and reflect if necessary
            let mirror_type = grid[r as usize][c as usize];
            if mirror_type == 1 { // Type 0 mirror ('\')
                d = d ^ 1;
            } else if mirror_type == 2 { // Type 1 mirror ('/')
                d = 3 - d;
            }
            // If mirror_type is 0 (no mirror), direction 'd' remains unchanged.
        }
    }
}
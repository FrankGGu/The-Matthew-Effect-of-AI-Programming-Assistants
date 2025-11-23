struct Solution;

impl Solution {
    pub fn fill_a_special_grid(n: i32, r: i32, c: i32) -> Vec<Vec<i32>> {
        let n_usize = n as usize;
        let mut grid: Vec<Vec<i32>> = vec![vec![0; n_usize]; n_usize];

        let mut curr_r: i32 = r;
        let mut curr_c: i32 = c;

        for k in 1..=(n * n) {
            grid[curr_r as usize][curr_c as usize] = k;

            // Calculate the next candidate position by moving one step up and one step right.
            // Wrap around if out of bounds.
            let next_r_candidate = (curr_r - 1 + n) % n;
            let next_c_candidate = (curr_c + 1) % n;

            // Check if the next candidate position is already occupied.
            if grid[next_r_candidate as usize][next_c_candidate as usize] != 0 {
                // If occupied, the rule is to move one step down from the current position.
                // The column remains the same.
                curr_r = (curr_r + 1) % n;
            } else {
                // If the next candidate position is free, move to it.
                curr_r = next_r_candidate;
                curr_c = next_c_candidate;
            }
        }

        grid
    }
}
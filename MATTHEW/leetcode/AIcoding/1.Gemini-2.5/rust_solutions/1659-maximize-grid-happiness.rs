struct Solution;

impl Solution {
    // Helper to extract the person type (2 bits) at a specific column from the mask.
    // 00: empty, 01: introvert, 10: extrovert
    fn get_person_type(mask: i32, col: i32) -> i32 {
        (mask >> (2 * col)) & 0b11
    }

    // Helper to set the person type (2 bits) at a specific column in the mask.
    fn set_person_type(mask: i32, col: i32, person_type: i32) -> i32 {
        (mask & !(0b11 << (2 * col))) | (person_type << (2 * col))
    }

    // Recursive DP function with memoization
    // r: current row
    // c: current column
    // i: introverts remaining
    // e: extroverts remaining
    // mask: a bitmask representing the state of the "profile" line.
    //       For cell (r, c), mask[2*k .. 2*k+1] represents:
    //       - (r, k) if k < c (cells in the current row already processed)
    //       - (r-1, k) if k >= c (cells in the previous row)
    // m, n: grid dimensions
    // memo: memoization table
    fn solve(
        r: i32,
        c: i32,
        i: i32,
        e: i32,
        mask: i32,
        m: i32,
        n: i32,
        memo: &mut Vec<Vec<Vec<Vec<Vec<i32>>>>>,
    ) -> i32 {
        // Base case: All rows processed
        if r == m {
            return 0;
        }

        // If current row is finished, move to the next row (column 0).
        // The `mask` argument to `solve(r+1, 0, ...)` will represent the state of row `r`.
        // This is consistent with the mask definition where mask[k] represents (r-1, k) when c=0.
        if c == n {
            return Self::solve(r + 1, 0, i, e, mask, m, n, memo);
        }

        // Check memoization table
        if memo[r as usize][c as usize][i as usize][e as usize][mask as usize] != -1 {
            return memo[r as usize][c as usize][i as usize][e as usize][mask as usize];
        }

        let mut max_happiness = 0;

        // Option 1: Place nothing (Empty) at (r, c)
        // Update the mask to reflect that (r, c) is empty (0b00).
        let next_mask_empty = Self::set_person_type(mask, c, 0b00);
        max_happiness = max_happiness.max(Self::solve(r, c + 1, i, e, next_mask_empty, m, n, memo));

        // Option 2: Place an introvert at (r, c)
        if i > 0 {
            let mut current_happiness = 120; // Base happiness for an introvert

            // Get types of neighbors
            let up_person_type = Self::get_person_type(mask, c); // (r-1, c)
            let mut left_person_type = 0;
            if c > 0 {
                left_person_type = Self::get_person_type(mask, c - 1); // (r, c-1)
            }

            // Calculate happiness contribution from neighbors
            // Up neighbor
            if up_person_type == 0b01 {
                current_happiness -= 60; // Introvert-Introvert
            } else if up_person_type == 0b10 {
                current_happiness -= 10; // Introvert-Extrovert
            }
            // Left neighbor
            if c > 0 {
                if left_person_type == 0b01 {
                    current_happiness -= 60; // Introvert-Introvert
                } else if left_person_type == 0b10 {
                    current_happiness -= 10; // Introvert-Extrovert
                }
            }

            // Update mask for introvert (0b01)
            let next_mask_introvert = Self::set_person_type(mask, c, 0b01);
            max_happiness = max_happiness.max(
                current_happiness + Self::solve(r, c + 1, i - 1, e, next_mask_introvert, m, n, memo),
            );
        }

        // Option 3: Place an extrovert at (r, c)
        if e > 0 {
            let mut current_happiness = 40; // Base happiness for an extrovert

            // Get types of neighbors
            let up_person_type = Self::get_person_type(mask, c); // (r-1, c)
            let mut left_person_type = 0;
            if c > 0 {
                left_person_type = Self::get_person_type(mask, c - 1); // (r, c-1)
            }

            // Calculate happiness contribution from neighbors
            // Up neighbor
            if up_person_type == 0b01 {
                current_happiness -= 10; // Extrovert-Introvert
            } else if up_person_type == 0b10 {
                current_happiness += 40; // Extrovert-Extrovert
            }
            // Left neighbor
            if c > 0 {
                if left_person_type == 0b01 {
                    current_happiness -= 10; // Extrovert-Introvert
                } else if left_person_type == 0b10 {
                    current_happiness += 40; // Extrovert-Extrovert
                }
            }

            // Update mask for extrovert (0b10)
            let next_mask_extrovert = Self::set_person_type(mask, c, 0b10);
            max_happiness = max_happiness.max(
                current_happiness + Self::solve(r, c + 1, i, e - 1, next_mask_extrovert, m, n, memo),
            );
        }

        // Store result in memoization table
        memo[r as usize][c as usize][i as usize][e as usize][mask as usize] = max_happiness;
        max_happiness
    }

    pub fn maximize_grid_happiness(
        m: i32,
        n: i32,
        introverts_count: i32,
        extroverts_count: i32,
    ) -> i32 {
        // Initialize memoization table:
        // memo[r][c][introverts_left][extroverts_left][mask]
        // r: 0 to m
        // c: 0 to n
        // introverts_left: 0 to introverts_count
        // extroverts_left: 0 to extroverts_count
        // mask: 0 to (1 << (2*n)) - 1 (2 bits per column for n columns)
        let max_mask_val = 1 << (2 * n);
        let mut memo = vec![
            vec![
                vec![
                    vec![vec![-1; max_mask_val]; (extroverts_count + 1) as usize];
                    (introverts_count + 1) as usize
                ];
                (n + 1) as usize
            ];
            (m + 1) as usize
        ];

        // Start DP from (0, 0) with initial counts and an empty mask (representing an empty previous row)
        Self::solve(0, 0, introverts_count, extroverts_count, 0, m, n, &mut memo)
    }
}
use std::collections::HashMap;

impl Solution {
    pub fn count_black_blocks(m: i32, n: i32, black_blocks: Vec<Vec<i32>>) -> Vec<i64> {
        let mut ans: Vec<i64> = vec![0; 5];

        let mut block_counts: HashMap<(i32, i32), i32> = HashMap::new();

        // Iterate through each black cell and identify all 2x2 blocks it could be part of.
        // A black cell (r_b, c_b) can be one of the four cells in a 2x2 block.
        // Let the top-left corner of a 2x2 block be (R, C).
        // The four cells in this block are (R, C), (R, C+1), (R+1, C), (R+1, C+1).
        // If (r_b, c_b) is a black cell, it could be:
        // 1. The top-left cell: (R, C) = (r_b, c_b)
        // 2. The top-right cell: (R, C+1) = (r_b, c_b) => (R, C) = (r_b, c_b - 1)
        // 3. The bottom-left cell: (R+1, C) = (r_b, c_b) => (R, C) = (r_b - 1, c_b)
        // 4. The bottom-right cell: (R+1, C+1) = (r_b, c_b) => (R, C) = (r_b - 1, c_b - 1)

        // dr_offset[i] and dc_offset[i] define the relative position of the black cell
        // from the top-left corner of the 2x2 block it belongs to.
        // For example, if dr_offset[i]=0, dc_offset[i]=0, the black cell is the top-left.
        // So, top_left_r = r_b - 0, top_left_c = c_b - 0.
        let dr_offset = [0, 0, 1, 1];
        let dc_offset = [0, 1, 0, 1];

        for block in &black_blocks {
            let r_b = block[0];
            let c_b = block[1];

            for i in 0..4 {
                let top_left_r = r_b - dr_offset[i];
                let top_left_c = c_b - dc_offset[i];

                // A 2x2 block with top-left (r,c) is valid if:
                // 0 <= r < m - 1
                // 0 <= c < n - 1
                if top_left_r >= 0 && top_left_r < m - 1 &&
                   top_left_c >= 0 && top_left_c < n - 1 {
                    *block_counts.entry((top_left_r, top_left_c)).or_insert(0) += 1;
                }
            }
        }

        // Populate ans[1] through ans[4] based on the counts of black cells in each 2x2 block
        for &count in block_counts.values() {
            ans[count as usize] += 1;
        }

        // Calculate ans[0] (number of 2x2 blocks with 0 black cells)
        let mut total_possible_2x2_blocks: i64 = 0;
        // There are (m-1) * (n-1) possible 2x2 blocks in an m x n grid.
        // This is only valid if m > 1 and n > 1.
        if m > 1 && n > 1 {
            total_possible_2x2_blocks = (m - 1) as i64 * (n - 1) as i64;
        }

        let sum_of_non_zero_blocks: i64 = ans[1] + ans[2] + ans[3] + ans[4];
        ans[0] = total_possible_2x2_blocks - sum_of_non_zero_blocks;

        ans
    }
}
impl Solution {
    pub fn find_diagonal_order(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let mut diagonals: Vec<Vec<i32>> = Vec::new();

        for r in 0..nums.len() {
            for c in 0..nums[r].len() {
                let s = r + c;
                while s >= diagonals.len() {
                    diagonals.push(Vec::new());
                }
                diagonals[s].push(nums[r][c]);
            }
        }

        let mut result = Vec::new();
        for mut diag_vec in diagonals {
            diag_vec.reverse();
            result.extend(diag_vec);
        }

        result
    }
}
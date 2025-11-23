impl Solution {
    pub fn find_diagonal_order(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut diagonals = std::collections::HashMap::new();

        for (i, row) in nums.iter().enumerate() {
            for (j, &num) in row.iter().enumerate() {
                diagonals.entry(i + j).or_insert_with(Vec::new).push(num);
            }
        }

        for k in 0..diagonals.len() {
            if let Some(diagonal) = diagonals.get_mut(&k) {
                if k % 2 == 0 {
                    result.extend(diagonal.iter().cloned());
                } else {
                    result.extend(diagonal.iter().rev().cloned());
                }
            }
        }

        result
    }
}
impl Solution {
    pub fn find_matrix(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut counts = std::collections::HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut result: Vec<Vec<i32>> = Vec::new();
        while !counts.is_empty() {
            let mut row: Vec<i32> = Vec::new();
            let mut to_remove: Vec<i32> = Vec::new();

            for (&num, &count) in &counts {
                row.push(num);
                if count == 1 {
                    to_remove.push(num);
                } else {
                    *counts.entry(num).or_insert(0) -= 1;
                }
            }

            for num in &to_remove {
                counts.remove(num);
            }

            result.push(row);
        }

        result
    }
}
use std::collections::BTreeSet;

impl Solution {
    pub fn max_sum_submatrix(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let (m, n) = (matrix.len(), matrix[0].len());
        let mut result = i32::MIN;

        for left in 0..n {
            let mut sums = vec![0; m];
            for right in left..n {
                for i in 0..m {
                    sums[i] += matrix[i][right];
                }

                let mut set = BTreeSet::new();
                set.insert(0);
                let mut curr_sum = 0;

                for sum in sums.iter() {
                    curr_sum += sum;
                    if let Some(&val) = set.range(..=curr_sum - k).next_back() {
                        result = result.max(curr_sum - val);
                    }
                    set.insert(curr_sum);
                }
            }
        }

        result
    }
}
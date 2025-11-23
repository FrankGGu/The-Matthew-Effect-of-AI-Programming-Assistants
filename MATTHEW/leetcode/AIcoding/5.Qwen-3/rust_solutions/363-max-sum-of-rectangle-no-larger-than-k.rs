impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeSet;

impl Solution {
    pub fn max_sum_submatrix(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut max_sum = i32::MIN;

        for left in 0..cols {
            let mut temp = vec![0; rows];
            for right in left..cols {
                for i in 0..rows {
                    temp[i] += matrix[i][right];
                }

                let mut sorted_prefix = BTreeSet::new();
                sorted_prefix.insert(0);
                let mut prefix_sum = 0;

                for &val in &temp {
                    prefix_sum += val;
                    match sorted_prefix.range(prefix_sum - k..).next() {
                        Some(&s) => {
                            if prefix_sum - s <= k {
                                max_sum = std::cmp::max(max_sum, prefix_sum - s);
                            }
                        }
                        None => {}
                    }
                    sorted_prefix.insert(prefix_sum);
                }
            }
        }

        max_sum
    }
}
}
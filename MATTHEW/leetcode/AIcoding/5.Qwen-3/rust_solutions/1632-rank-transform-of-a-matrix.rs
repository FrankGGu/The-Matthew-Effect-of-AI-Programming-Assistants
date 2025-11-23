impl Solution {

use std::collections::{HashMap, BTreeSet};

impl Solution {
    pub fn array_rank_transform(mut matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let rows = matrix.len();
        let cols = matrix[0].len();

        let mut values = BTreeSet::new();
        for row in &matrix {
            for &val in row {
                values.insert(val);
            }
        }

        let mut value_to_rank = HashMap::new();
        let mut rank = 1;
        for val in values {
            value_to_rank.insert(val, rank);
            rank += 1;
        }

        for row in &mut matrix {
            for val in row {
                *val = value_to_rank[val];
            }
        }

        matrix
    }
}
}
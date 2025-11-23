impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn equal_frequency(mat: Vec<Vec<char>>) -> i32 {
        let mut count = HashMap::new();
        let mut result = 0;

        for i in 0..mat.len() {
            for j in 0..mat[0].len() {
                *count.entry(mat[i][j]).or_insert(0) += 1;
            }
        }

        for i in 0..mat.len() {
            for j in 0..mat[0].len() {
                let c = mat[i][j];
                *count.get_mut(&c).unwrap() -= 1;
                if *count.get(&c).unwrap() == 0 {
                    count.remove(&c);
                }

                let mut freq = HashMap::new();
                for k in 0..mat.len() {
                    for l in 0..mat[0].len() {
                        if k == i && l == j {
                            continue;
                        }
                        *freq.entry(mat[k][l]).or_insert(0) += 1;
                    }
                }

                if freq.len() == 1 {
                    result += 1;
                }

                *count.entry(c).or_insert(0) += 1;
            }
        }

        result
    }
}
}
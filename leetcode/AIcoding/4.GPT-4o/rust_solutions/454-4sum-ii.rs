use std::collections::HashMap;

impl Solution {
    pub fn four_sum_count(A: Vec<i32>, B: Vec<i32>, C: Vec<i32>, D: Vec<i32>) -> i32 {
        let mut count_map = HashMap::new();
        for &a in &A {
            for &b in &B {
                *count_map.entry(a + b).or_insert(0) += 1;
            }
        }
        let mut count = 0;
        for &c in &C {
            for &d in &D {
                count += count_map.get(&(-(c + d))).unwrap_or(&0);
            }
        }
        count
    }
}
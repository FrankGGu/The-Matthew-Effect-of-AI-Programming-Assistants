impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn maximize_greatness(a: Vec<i32>) -> i32 {
        let mut a_sorted = a.clone();
        a_sorted.sort();
        let mut b = a.clone();
        b.sort();
        let mut i = 0;
        let mut j = 0;
        let mut count = 0;
        while i < a_sorted.len() && j < b.len() {
            if a_sorted[i] > b[j] {
                count += 1;
                j += 1;
            }
            i += 1;
        }
        count as i32
    }
}
}
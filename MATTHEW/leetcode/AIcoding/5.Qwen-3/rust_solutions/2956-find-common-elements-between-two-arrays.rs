impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn find_intersection(arr1: Vec<i32>, arr2: Vec<i32>) -> Vec<i32> {
        let set1: HashSet<i32> = arr1.into_iter().collect();
        let set2: HashSet<i32> = arr2.into_iter().collect();
        let intersection: HashSet<_> = set1.intersection(&set2).cloned().collect();
        intersection.into_iter().collect()
    }
}
}
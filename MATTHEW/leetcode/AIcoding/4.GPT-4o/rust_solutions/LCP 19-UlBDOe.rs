impl Solution {
    pub fn num_collections(arr: Vec<i32>) -> i32 {
        use std::collections::HashSet;
        let mut set = HashSet::new();
        for &x in arr.iter() {
            set.insert(x);
        }
        set.len() as i32
    }
}
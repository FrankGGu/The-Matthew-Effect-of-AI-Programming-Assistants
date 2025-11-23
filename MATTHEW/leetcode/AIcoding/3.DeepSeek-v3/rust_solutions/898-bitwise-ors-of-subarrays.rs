use std::collections::HashSet;

impl Solution {
    pub fn subarray_bitwise_o_rs(arr: Vec<i32>) -> i32 {
        let mut res = HashSet::new();
        let mut prev = HashSet::new();

        for &num in arr.iter() {
            let mut curr = HashSet::new();
            curr.insert(num);
            for &val in prev.iter() {
                curr.insert(val | num);
            }
            for &val in curr.iter() {
                res.insert(val);
            }
            prev = curr;
        }

        res.len() as i32
    }
}
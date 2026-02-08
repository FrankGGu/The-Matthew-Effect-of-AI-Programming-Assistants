use std::collections::BTreeMap;

impl Solution {
    pub fn odd_even_jumps(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n == 0 {
            return 0;
        }
        let mut odd = vec![false; n];
        let mut even = vec![false; n];
        odd[n - 1] = true;
        even[n - 1] = true;
        let mut map = BTreeMap::new();
        map.insert(arr[n - 1], n - 1);
        let mut res = 1;
        for i in (0..n - 1).rev() {
            let val = arr[i];
            if let Some((_, &j)) = map.range(val..).next() {
                odd[i] = even[j];
            }
            if let Some((_, &j)) = map.range(..=val).rev().next() {
                even[i] = odd[j];
            }
            if odd[i] {
                res += 1;
            }
            map.insert(val, i);
        }
        res
    }
}
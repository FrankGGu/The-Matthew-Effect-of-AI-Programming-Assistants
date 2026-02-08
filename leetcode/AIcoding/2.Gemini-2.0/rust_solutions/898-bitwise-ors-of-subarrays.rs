impl Solution {
    pub fn subarray_bitwise_or_s(arr: Vec<i32>) -> i32 {
        let mut ans = std::collections::HashSet::new();
        let mut cur = std::collections::HashSet::new();
        for &x in &arr {
            let mut cur2 = std::collections::HashSet::new();
            cur2.insert(x);
            for &y in &cur {
                cur2.insert(x | y);
            }
            for &y in &cur2 {
                ans.insert(y);
            }
            cur = cur2;
        }
        ans.len() as i32
    }
}
impl Solution {
    pub fn shortest_sequence(rolls: Vec<i32>, k: i32) -> i32 {
        let mut res = 1;
        let mut s = std::collections::HashSet::new();
        for &num in &rolls {
            s.insert(num);
            if s.len() == k as usize {
                res += 1;
                s.clear();
            }
        }
        res
    }
}
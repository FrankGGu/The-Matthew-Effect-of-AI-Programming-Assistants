impl Solution {
    pub fn h_index(citations: Vec<i32>) -> i32 {
        let n = citations.len();
        let mut citations = citations;
        citations.sort_unstable_by(|a, b| b.cmp(a));

        for i in 0..n {
            if citations[i] as usize > i {
                continue;
            } else {
                return i as i32;
            }
        }

        n as i32
    }
}
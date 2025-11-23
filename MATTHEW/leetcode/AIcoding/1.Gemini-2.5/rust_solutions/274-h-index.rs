impl Solution {
    pub fn h_index(mut citations: Vec<i32>) -> i32 {
        citations.sort();
        let n = citations.len();
        for i in 0..n {
            let h_candidate = (n - i) as i32;
            if citations[i] >= h_candidate {
                return h_candidate;
            }
        }
        0
    }
}
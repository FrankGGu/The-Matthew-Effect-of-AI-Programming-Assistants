impl Solution {
    pub fn h_index(citations: Vec<i32>) -> i32 {
        let mut citations = citations;
        citations.sort_unstable_by(|a, b| b.cmp(a));
        let mut h = 0;
        for (i, &citation) in citations.iter().enumerate() {
            if citation >= (i + 1) as i32 {
                h = (i + 1) as i32;
            } else {
                break;
            }
        }
        h
    }
}
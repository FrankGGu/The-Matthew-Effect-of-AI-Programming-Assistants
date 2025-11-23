impl Solution {
    pub fn decode(encoded: Vec<i32>, first: i32) -> Vec<i32> {
        let mut decoded = vec![first];
        for &e in &encoded {
            decoded.push(decoded.last().unwrap() ^ e);
        }
        decoded
    }
}
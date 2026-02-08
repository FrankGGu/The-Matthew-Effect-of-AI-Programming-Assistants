impl Solution {
    pub fn decode(encoded: Vec<i32>, first: i32) -> Vec<i32> {
        let mut decoded = vec![first];
        for &num in encoded.iter() {
            let next = decoded.last().unwrap() ^ num;
            decoded.push(next);
        }
        decoded
    }
}
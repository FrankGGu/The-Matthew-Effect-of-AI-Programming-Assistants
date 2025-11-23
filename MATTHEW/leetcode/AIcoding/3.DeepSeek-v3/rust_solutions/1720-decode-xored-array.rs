impl Solution {
    pub fn decode(encoded: Vec<i32>, first: i32) -> Vec<i32> {
        let mut result = vec![first];
        for &num in encoded.iter() {
            let next = result.last().unwrap() ^ num;
            result.push(next);
        }
        result
    }
}
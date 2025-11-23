impl Solution {
    pub fn decode(encoded: Vec<i32>) -> Vec<i32> {
        let n = encoded.len() + 1;
        let mut total_xor = 0;
        for i in 1..=n {
            total_xor ^= i;
        }
        let mut odd_xor = 0;
        for i in (1..encoded.len()).step_by(2) {
            odd_xor ^= encoded[i];
        }
        let first = total_xor ^ odd_xor;
        let mut perm = vec![first];
        for &num in encoded.iter() {
            perm.push(perm.last().unwrap() ^ num);
        }
        perm
    }
}
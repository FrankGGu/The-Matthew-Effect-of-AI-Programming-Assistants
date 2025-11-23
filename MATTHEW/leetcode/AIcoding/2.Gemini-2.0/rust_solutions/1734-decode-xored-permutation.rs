impl Solution {
    pub fn decode(encoded: Vec<i32>, first: i32) -> Vec<i32> {
        let n = encoded.len() + 1;
        let mut perm = vec![0; n];
        perm[0] = first;
        for i in 0..encoded.len() {
            perm[i + 1] = perm[i] ^ encoded[i];
        }
        perm
    }
}
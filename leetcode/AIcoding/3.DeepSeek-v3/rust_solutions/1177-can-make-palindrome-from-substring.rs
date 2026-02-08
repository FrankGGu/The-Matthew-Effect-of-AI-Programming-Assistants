impl Solution {
    pub fn can_make_pali_queries(s: String, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let s = s.as_bytes();
        let n = s.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] ^ (1 << (s[i] - b'a'));
        }
        queries.into_iter().map(|q| {
            let (l, r, k) = (q[0] as usize, q[1] as usize, q[2]);
            let bits = prefix[r + 1] ^ prefix[l];
            let odd = bits.count_ones() as i32;
            odd / 2 <= k
        }).collect()
    }
}
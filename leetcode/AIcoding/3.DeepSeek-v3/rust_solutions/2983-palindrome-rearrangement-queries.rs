impl Solution {
    pub fn can_make_pali_queries(s: String, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let s_bytes = s.as_bytes();
        let n = s_bytes.len();
        let mut prefix = vec![0; n + 1];

        for i in 0..n {
            prefix[i + 1] = prefix[i] ^ (1 << (s_bytes[i] - b'a'));
        }

        queries.into_iter().map(|q| {
            let left = q[0] as usize;
            let right = q[1] as usize;
            let k = q[2] as usize;
            let mask = prefix[right + 1] ^ prefix[left];
            let odd_count = (mask.count_ones() as usize);
            odd_count / 2 <= k
        }).collect()
    }
}
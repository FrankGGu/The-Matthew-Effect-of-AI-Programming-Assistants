impl Solution {
    pub fn can_make_palindrome_queries(s: String, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = s.len();
        let s_bytes = s.as_bytes();

        let mut prefix_xor = vec![0u32; n + 1];
        for i in 0..n {
            let char_code = (s_bytes[i] - b'a') as u32;
            prefix_xor[i + 1] = prefix_xor[i] ^ (1 << char_code);
        }

        let mut results = Vec::with_capacity(queries.len());

        for query in queries {
            let left = query[0] as usize;
            let right = query[1] as usize;
            let k = query[2] as u32;

            let sub_mask = prefix_xor[right + 1] ^ prefix_xor[left];

            let odd_counts = sub_mask.count_ones();

            let min_changes_needed = odd_counts / 2;

            results.push(min_changes_needed <= k);
        }

        results
    }
}
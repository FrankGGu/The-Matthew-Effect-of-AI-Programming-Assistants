impl Solution {
    pub fn can_make_pali_queries(s: String, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = s.len();
        let mut count = vec![0; 26];
        let mut prefix = vec![0; n + 1];

        for (i, c) in s.chars().enumerate() {
            count[c as usize - 'a' as usize] += 1;
            prefix[i + 1] = prefix[i] + (count[c as usize - 'a' as usize] % 2);
        }

        queries
            .into_iter()
            .map(|query| {
                let (left, right, k) = (query[0] as usize, query[1] as usize, query[2]);
                let odd_count = prefix[right + 1] - prefix[left];
                odd_count / 2 <= k
            })
            .collect()
    }
}
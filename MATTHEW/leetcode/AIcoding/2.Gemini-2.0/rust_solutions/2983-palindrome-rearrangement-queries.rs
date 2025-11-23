impl Solution {
    pub fn can_make_palindrome_queries(s: String, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut prefix: Vec<i32> = vec![0; n + 1];
        for i in 0..n / 2 {
            if s[i] != s[n - 1 - i] {
                prefix[i + 1] = prefix[i] + 1;
            } else {
                prefix[i + 1] = prefix[i];
            }
        }
        for i in n / 2..n + 1 {
            prefix[i] = prefix[n / 2];
        }

        let mut result: Vec<bool> = Vec::new();
        for query in queries {
            let l = query[0] as usize;
            let r = query[1] as usize;
            let p = query[2] as usize;
            let q = query[3] as usize;

            let left = l.min(n - 1 - q);
            let right = r.max(n - 1 - p);
            let changes = (r - l + 1) / 2;
            let diff = prefix[(n / 2).min(right + 1)] - prefix[left];
            if changes >= diff {
                result.push(true);
            } else {
                result.push(false);
            }
        }
        result
    }
}
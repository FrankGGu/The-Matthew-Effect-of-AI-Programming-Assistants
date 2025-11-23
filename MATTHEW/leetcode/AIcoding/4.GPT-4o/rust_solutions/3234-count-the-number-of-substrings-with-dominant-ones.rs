impl Solution {
    pub fn count_dominant_substrings(s: String) -> i64 {
        let n = s.len();
        let bytes = s.as_bytes();
        let mut count = vec![0; n + 1];
        for i in 0..n {
            count[i + 1] = count[i] + (bytes[i] == b'1') as i64;
        }

        let mut result = 0;
        for i in 0..n {
            for j in i..n {
                let ones = count[j + 1] - count[i];
                let zeros = (j - i + 1) as i64 - ones;
                if ones > zeros {
                    result += 1;
                }
            }
        }
        result
    }
}
impl Solution {
    pub fn substring_xor_queries(s: String, queries: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut results = Vec::new();
        let n = s.len();

        for query in queries {
            let target = query[0];
            let mut found = false;
            for length in 1..=min(n, 30) {
                for start in 0..=n-length {
                    let substring = &s[start..start+length];
                    let num = isize::from_str_radix(substring, 2).unwrap();
                    if num == target {
                        results.push(vec![start as i32, start as i32 + length as i32 - 1]);
                        found = true;
                        break;
                    }
                }
                if found {
                    break;
                }
            }
            if !found {
                results.push(vec![-1, -1]);
            }
        }

        results
    }
}
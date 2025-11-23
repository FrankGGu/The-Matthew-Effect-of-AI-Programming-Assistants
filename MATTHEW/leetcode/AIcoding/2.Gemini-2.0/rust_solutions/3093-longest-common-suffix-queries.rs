impl Solution {
    pub fn longest_common_suffix(s1: String, s2: String, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();
        let mut result = Vec::new();
        for query in queries {
            let l1 = query[0] as usize;
            let r1 = query[1] as usize;
            let l2 = query[2] as usize;
            let r2 = query[3] as usize;

            let mut len = 0;
            while len < r1 - l1 + 1 && len < r2 - l2 + 1 {
                if s1_bytes[r1 - len] == s2_bytes[r2 - len] {
                    len += 1;
                } else {
                    break;
                }
            }
            result.push(len as i32);
        }
        result
    }
}
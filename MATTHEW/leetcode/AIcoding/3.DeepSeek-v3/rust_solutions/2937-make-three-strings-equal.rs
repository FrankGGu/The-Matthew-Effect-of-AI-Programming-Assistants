impl Solution {
    pub fn find_minimum_operations(s1: String, s2: String, s3: String) -> i32 {
        let s1 = s1.as_bytes();
        let s2 = s2.as_bytes();
        let s3 = s3.as_bytes();
        let min_len = s1.len().min(s2.len()).min(s3.len());
        let mut common = 0;

        for i in 0..min_len {
            if s1[i] == s2[i] && s2[i] == s3[i] {
                common += 1;
            } else {
                break;
            }
        }

        if common == 0 {
            -1
        } else {
            (s1.len() + s2.len() + s3.len() - 3 * common) as i32
        }
    }
}
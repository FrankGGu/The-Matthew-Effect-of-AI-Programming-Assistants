impl Solution {
    pub fn find_minimum_operations(s1: String, s2: String, s3: String) -> i32 {
        let n1 = s1.len();
        let n2 = s2.len();
        let n3 = s3.len();

        let bytes1 = s1.as_bytes();
        let bytes2 = s2.as_bytes();
        let bytes3 = s3.as_bytes();

        let mut common_length = 0;
        let min_len = std::cmp::min(n1, std::cmp::min(n2, n3));

        for i in 0..min_len {
            if bytes1[i] == bytes2[i] && bytes2[i] == bytes3[i] {
                common_length += 1;
            } else {
                break;
            }
        }

        if common_length == 0 {
            return -1;
        }

        (n1 as i32 - common_length as i32) + (n2 as i32 - common_length as i32) + (n3 as i32 - common_length as i32)
    }
}
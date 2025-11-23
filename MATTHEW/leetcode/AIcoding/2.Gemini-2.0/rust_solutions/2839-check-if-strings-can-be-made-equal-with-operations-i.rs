impl Solution {
    pub fn can_be_equal(s1: String, s2: String) -> bool {
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();

        let mut s1_arr = [s1_bytes[0], s1_bytes[2]];
        let mut s2_arr = [s2_bytes[0], s2_bytes[2]];
        s1_arr.sort();
        s2_arr.sort();

        let mut s3_arr = [s1_bytes[1], s1_bytes[3]];
        let mut s4_arr = [s2_bytes[1], s2_bytes[3]];
        s3_arr.sort();
        s4_arr.sort();

        return s1_arr == s2_arr && s3_arr == s4_arr;
    }
}
impl Solution {
    pub fn find_array(pref: Vec<i32>) -> Vec<i32> {
        let n = pref.len();
        let mut result = vec![0; n];
        result[0] = pref[0];
        for i in 1..n {
            result[i] = pref[i] ^ pref[i - 1];
        }
        result
    }
}
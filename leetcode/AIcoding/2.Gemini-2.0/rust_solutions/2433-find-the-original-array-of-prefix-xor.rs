impl Solution {
    pub fn find_the_original_array(pref: Vec<i32>) -> Vec<i32> {
        let mut original = vec![0; pref.len()];
        original[0] = pref[0];
        for i in 1..pref.len() {
            original[i] = pref[i] ^ pref[i - 1];
        }
        original
    }
}
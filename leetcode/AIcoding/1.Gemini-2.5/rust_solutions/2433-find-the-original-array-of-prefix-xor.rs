impl Solution {
    pub fn find_array(pref: Vec<i32>) -> Vec<i32> {
        let n = pref.len();
        let mut arr = vec![0; n];

        arr[0] = pref[0];

        for i in 1..n {
            arr[i] = pref[i] ^ pref[i - 1];
        }

        arr
    }
}
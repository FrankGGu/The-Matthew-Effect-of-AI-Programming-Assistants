impl Solution {
    pub fn find_array(pref: Vec<i32>) -> Vec<i32> {
        let mut res = Vec::with_capacity(pref.len());
        if pref.is_empty() {
            return res;
        }
        res.push(pref[0]);
        for i in 1..pref.len() {
            res.push(pref[i - 1] ^ pref[i]);
        }
        res
    }
}
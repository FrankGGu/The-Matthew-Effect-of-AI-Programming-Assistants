impl Solution {
    pub fn check_strings(s1: String, s2: String) -> bool {
        if s1.len() != s2.len() {
            return false;
        }
        let mut even1 = vec![0; 26];
        let mut odd1 = vec![0; 26];
        let mut even2 = vec![0; 26];
        let mut odd2 = vec![0; 26];
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();
        for i in 0..s1.len() {
            let c1 = s1_bytes[i] - b'a';
            let c2 = s2_bytes[i] - b'a';
            if i % 2 == 0 {
                even1[c1 as usize] += 1;
                even2[c2 as usize] += 1;
            } else {
                odd1[c1 as usize] += 1;
                odd2[c2 as usize] += 1;
            }
        }
        even1 == even2 && odd1 == odd2
    }
}
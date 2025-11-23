impl Solution {
    pub fn can_construct(s: String, k: i32) -> bool {
        let k = k as usize;
        let n = s.len();
        if k > n {
            return false;
        }
        let mut freq = [0; 26];
        for c in s.chars() {
            freq[(c as u8 - b'a') as usize] += 1;
        }
        let mut odd_count = 0;
        for &count in freq.iter() {
            if count % 2 != 0 {
                odd_count += 1;
            }
        }
        odd_count <= k
    }
}
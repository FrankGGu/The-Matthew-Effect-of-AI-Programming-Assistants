impl Solution {
    pub fn is_anagram(s: String, t: String) -> bool {
        let mut count = [0; 26];
        for c in s.chars() {
            count[c as usize - 'a' as usize] += 1;
        }
        for c in t.chars() {
            count[c as usize - 'a' as usize] -= 1;
        }
        count.iter().all(|&x| x == 0)
    }
}
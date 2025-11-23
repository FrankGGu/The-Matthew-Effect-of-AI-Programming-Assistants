impl Solution {
    pub fn can_reorder_to_equal(s: String) -> bool {
        let mut count = [0; 26];
        for c in s.chars() {
            count[(c as usize) - ('a' as usize)] += 1;
        }
        count.iter().all(|&x| x % s.len() == 0)
    }
}
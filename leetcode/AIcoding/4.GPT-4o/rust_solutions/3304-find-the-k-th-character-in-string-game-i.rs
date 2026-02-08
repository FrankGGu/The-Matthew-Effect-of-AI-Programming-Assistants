impl Solution {
    pub fn find_kth_character(s: String, k: i32) -> char {
        let mut count = 0;
        let k = k as usize;
        for c in s.chars() {
            count += 1;
            if count == k {
                return c;
            }
        }
        ' ' // return a space if k is out of bounds
    }
}
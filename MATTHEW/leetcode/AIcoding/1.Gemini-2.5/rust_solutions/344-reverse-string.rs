impl Solution {
    pub fn reverse_string(s: &mut Vec<char>) {
        let mut left = 0;
        let mut right = s.len() as i32 - 1;

        while left < right {
            s.swap(left as usize, right as usize);
            left += 1;
            right -= 1;
        }
    }
}
impl Solution {
    pub fn longest_palindrome(s: String) -> i32 {
        let mut counts = [0; 128]; 
        for c in s.chars() {
            counts[c as usize] += 1;
        }

        let mut length = 0;
        let mut has_odd = false;

        for &count in counts.iter() {
            length += (count / 2) * 2;
            if count % 2 == 1 {
                has_odd = true;
            }
        }

        if has_odd {
            length += 1;
        }

        length
    }
}
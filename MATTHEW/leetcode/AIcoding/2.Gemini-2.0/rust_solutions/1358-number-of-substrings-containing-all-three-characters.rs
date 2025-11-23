impl Solution {
    pub fn number_of_substrings(s: String) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut count = 0;
        let mut left = 0;
        let mut counts = [0; 3];

        for right in 0..n {
            counts[(s[right] - b'a') as usize] += 1;

            while counts[0] > 0 && counts[1] > 0 && counts[2] > 0 {
                count += (n - right) as i32;
                counts[(s[left] - b'a') as usize] -= 1;
                left += 1;
            }
        }

        count
    }
}
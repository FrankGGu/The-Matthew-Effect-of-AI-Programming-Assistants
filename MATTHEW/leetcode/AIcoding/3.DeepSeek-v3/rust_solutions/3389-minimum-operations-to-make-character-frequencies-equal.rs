impl Solution {
    pub fn min_operations(s: String) -> i32 {
        let mut freq = [0; 26];
        for c in s.chars() {
            freq[(c as u8 - b'a') as usize] += 1;
        }

        let max_freq = *freq.iter().max().unwrap();
        let mut operations = 0;

        for &count in freq.iter() {
            if count > 0 {
                operations += max_freq - count;
            }
        }

        operations
    }
}
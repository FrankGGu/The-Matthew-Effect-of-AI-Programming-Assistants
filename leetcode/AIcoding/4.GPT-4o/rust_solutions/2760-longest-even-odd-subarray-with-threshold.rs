impl Solution {
    pub fn longest_even_odd_subarray(arr: Vec<i32>, threshold: i32) -> i32 {
        let mut max_length = 0;
        let mut current_length = 0;
        let mut last_parity = -1;

        for &num in &arr {
            if num <= threshold {
                let current_parity = num % 2;
                if current_parity != last_parity {
                    current_length += 1;
                } else {
                    current_length = 1;
                }
                last_parity = current_parity;
                max_length = max_length.max(current_length);
            } else {
                current_length = 0;
                last_parity = -1;
            }
        }
        max_length
    }
}
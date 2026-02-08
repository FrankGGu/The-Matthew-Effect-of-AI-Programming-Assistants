impl Solution {
    pub fn count_substrings_divisible_by_last_digit(s: String) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();
        let mut ans = 0;

        for j in 0..n {
            let d = chars[j].to_digit(10).unwrap();

            // The problem statement implies d will not be 0.
            // If d were 0, division would be undefined.

            let mut current_num_mod_d = 0;
            let mut power_of_10_mod_d = 1; // Represents 10^0 % d for the rightmost digit

            // Iterate 'i' from 'j' down to '0' to form substrings s[i..j]
            for i in (0..=j).rev() {
                let digit_i = chars[i].to_digit(10).unwrap();

                // Calculate (value of s[i..j]) % d
                // The value of substring s[i..j] can be expressed as:
                // digit_i * 10^(j-i) + value(s[i+1..j])
                //
                // In this loop:
                // - 'digit_i' is s[i].
                // - 'power_of_10_mod_d' is 10^(j-i) % d.
                // - 'current_num_mod_d' stores (value of s[i+1..j]) % d from the previous iteration (i+1).
                //   For the first iteration (i=j), current_num_mod_d is 0 (value of empty string).
                current_num_mod_d = (digit_i * power_of_10_mod_d + current_num_mod_d) % d;

                if current_num_mod_d == 0 {
                    ans += 1;
                }

                // Update 'power_of_10_mod_d' for the next iteration (i-1)
                // For the next digit s[i-1], it will be multiplied by 10^(j-(i-1)) = 10^(j-i+1).
                // So, we multiply the current 10^(j-i) % d by 10.
                power_of_10_mod_d = (power_of_10_mod_d * 10) % d;
            }
        }

        ans
    }
}
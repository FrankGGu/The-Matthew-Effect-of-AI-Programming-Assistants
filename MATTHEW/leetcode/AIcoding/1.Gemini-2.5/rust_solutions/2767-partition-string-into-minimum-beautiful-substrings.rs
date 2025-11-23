use std::collections::HashSet;
use std::cmp::min;

impl Solution {
    pub fn minimum_beautiful_substrings(s: String) -> i32 {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();

        let mut powers_of_5_binary: HashSet<String> = HashSet::new();
        let mut curr_power: u32 = 1;
        // Powers of 5 that can be represented by at most 15 bits (max value 2^15 - 1 = 32767)
        // 5^0 = 1, 5^1 = 5, ..., 5^6 = 15625. 5^7 = 78125 (too large).
        while curr_power <= 32767 {
            powers_of_5_binary.insert(format!("{:b}", curr_power));
            // Check for overflow before multiplication, though not strictly necessary for u32 with 5^7
            if let Some(next_power) = curr_power.checked_mul(5) {
                curr_power = next_power;
            } else {
                break; 
            }
        }

        // dp[i] will store the minimum number of beautiful substrings to partition s[i..n-1]
        // Initialize with a value indicating infinity (n + 1 is a safe upper bound, as max partitions is n)
        let mut dp: Vec<i32> = vec![n as i32 + 1; n + 1];
        dp[n] = 0; // Base case: an empty string requires 0 partitions

        // Iterate from the end of the string backwards
        for i in (0..n).rev() {
            // A beautiful number (which is a positive integer) cannot start with '0'
            if s_chars[i] == '0' {
                continue;
            }

            // Try all possible substrings starting at index i
            for j in i..n {
                let sub_str: String = s_chars[i..=j].iter().collect();

                // If the current substring is a power of 5
                if powers_of_5_binary.contains(&sub_str) {
                    // If the remaining part of the string (s[j+1..n-1]) can be partitioned
                    if dp[j + 1] != n as i32 + 1 { 
                        // Update dp[i] with the minimum partitions found so far
                        dp[i] = min(dp[i], 1 + dp[j + 1]);
                    }
                }
            }
        }

        // If dp[0] is still the initial 'infinity' value, it means the string cannot be partitioned
        if dp[0] == n as i32 + 1 {
            -1 
        } else {
            dp[0]
        }
    }
}
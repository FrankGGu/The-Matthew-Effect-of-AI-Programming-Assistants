impl Solution {
    pub fn minimum_length_of_anagram_concatenation(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();

        for k in 1..=n {
            if n % k == 0 {
                // k is a divisor of n, so it's a potential length for the base substring.

                // Calculate the character frequency map for the first substring s[0...k-1].
                let mut base_freq = [0; 26]; // For lowercase English letters 'a' through 'z'
                for i in 0..k {
                    base_freq[(s_bytes[i] - b'a') as usize] += 1;
                }

                let mut is_valid_k = true;
                // Check all subsequent substrings of length k.
                // There are n/k such substrings in total. The first one is already processed.
                for i in 1..(n / k) {
                    let start_idx = i * k;
                    let end_idx = (i + 1) * k;

                    let mut current_freq = [0; 26];
                    for j in start_idx..end_idx {
                        current_freq[(s_bytes[j] - b'a') as usize] += 1;
                    }

                    // If the current substring's frequency map does not match the base_freq,
                    // then k is not a valid length.
                    if current_freq != base_freq {
                        is_valid_k = false;
                        break;
                    }
                }

                // If all substrings were anagrams of the first one, then k is the minimum
                // length because we are iterating k in increasing order.
                if is_valid_k {
                    return k as i32;
                }
            }
        }

        // This line should theoretically not be reached because k=n is always a valid solution.
        // If k=n, the loop for 'i' (1 to n/k - 1) will be '1 to 0', which doesn't run,
        // making is_valid_k true and returning n.
        n as i32 
    }
}
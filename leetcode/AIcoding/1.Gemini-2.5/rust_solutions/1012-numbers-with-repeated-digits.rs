struct Solution;

impl Solution {
    fn permutations(n: i32, k: i32) -> i32 {
        if k < 0 || k > n {
            return 0;
        }
        if k == 0 {
            return 1;
        }
        let mut res = 1;
        for i in 0..k {
            res *= (n - i);
        }
        res
    }

    pub fn num_dup_digits_at_most_n(n: i32) -> i32 {
        let s_chars: Vec<char> = n.to_string().chars().collect();
        let k = s_chars.len() as i32;

        let mut total_non_repeated = 0;

        // Count numbers with no repeated digits and fewer than k digits
        // For L digits: first digit has 9 choices (1-9), remaining L-1 digits from 9 choices.
        for i in 1..k {
            total_non_repeated += 9 * Self::permutations(9, i - 1);
        }

        // Count numbers with no repeated digits and exactly k digits, up to N
        let mut visited_digits = vec![false; 10]; // Tracks digits used in the prefix s_chars[0...i-1]

        for i in 0..k {
            let d = s_chars[i].to_digit(10).unwrap() as i32;

            // For current position i, try placing digits j from start_j to d-1
            // The first digit (i=0) cannot be 0.
            let start_j = if i == 0 { 1 } else { 0 };

            for j in start_j..d {
                if visited_digits[j as usize] {
                    continue; // Digit j is already in the prefix, so this number has repeated digits
                }
                // We have fixed i digits from prefix s_chars[0...i-1] and current digit j.
                // Total (i+1) distinct digits are used for the prefix s_chars[0...i-1]j.
                // Remaining digits to choose from: 10 - (i + 1)
                // Remaining positions to fill: k - 1 - i
                total_non_repeated += Self::permutations(10 - (i + 1), k - 1 - i);
            }

            // If the current digit d from N itself is already visited,
            // then any number formed with this prefix s_chars[0...i] will have repeated digits.
            // So we cannot extend this prefix to form a non-repeated number. Break.
            if visited_digits[d as usize] {
                break;
            }
            // Mark digit d as visited for the next iteration's prefix check
            visited_digits[d as usize] = true;

            // If we reached the last digit (i == k-1) and no repetition so far,
            // it means N itself is a non-repeated number. Add 1.
            if i == k - 1 {
                total_non_repeated += 1;
            }
        }

        n - total_non_repeated
    }
}
impl Solution {
    pub fn maximum_swap(num: i32) -> i32 {
        let mut s = num.to_string().chars().collect::<Vec<char>>();
        let n = s.len();

        let mut last_pos: [i32; 10] = [-1; 10]; // Stores the rightmost index of each digit

        // Populate last_pos array
        // last_pos[d] will store the index of the rightmost occurrence of digit d
        for i in 0..n {
            last_pos[(s[i] as u8 - b'0') as usize] = i as i32;
        }

        // Iterate through the digits from left to right
        for i in 0..n {
            let current_digit = (s[i] as u8 - b'0') as usize;

            // Try to find a larger digit 'd' (from 9 down to current_digit + 1)
            // that exists to the right of the current digit s[i]
            for d in (current_digit + 1)..=9 {
                // If a larger digit 'd' exists and its rightmost occurrence is to the right of 'i'
                if last_pos[d] != -1 && (last_pos[d] as usize) > i {
                    // This is the optimal swap: swap s[i] with s[last_pos[d]]
                    // This ensures the largest possible digit is moved to the leftmost possible position
                    // to maximize the number.
                    let swap_idx = last_pos[d] as usize;
                    s.swap(i, swap_idx);

                    // Convert the modified vector of chars back to an i32 and return
                    return s.iter().collect::<String>().parse::<i32>().unwrap();
                }
            }
        }

        // If no swap was made after checking all digits,
        // the number is already in its maximum possible form.
        num
    }
}
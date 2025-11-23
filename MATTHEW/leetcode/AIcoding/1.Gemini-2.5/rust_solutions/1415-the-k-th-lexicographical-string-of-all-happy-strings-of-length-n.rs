impl Solution {
    pub fn get_happy_string(n: i32, k: i32) -> String {
        let mut k = k;
        let mut res_chars = Vec::with_capacity(n as usize);
        let mut prev_char: Option<char> = None;

        // Calculate the total number of happy strings of length n.
        // For the first character, there are 3 choices.
        // For each subsequent character, there are 2 choices (must be different from previous).
        // So, total = 3 * (2^(n-1)).
        let total_happy_strings = 3 * (1 << (n - 1));

        // If k is greater than the total number of happy strings, return an empty string.
        if k > total_happy_strings {
            return "".to_string();
        }

        for i in 0..n {
            // num_suffixes represents the number of happy strings of length (n - 1 - i)
            // that can be formed starting with a specific character.
            // This is 2^(remaining_length - 1) which is 2^((n-i)-1) = 2^(n-1-i).
            let num_suffixes = 1 << (n - 1 - i);

            // Iterate through possible characters ('a', 'b', 'c') in lexicographical order.
            // For each character, check if it's a valid choice (different from prev_char).
            // If valid, determine if the k-th string falls into the branch starting with this character.
            for &c in &['a', 'b', 'c'] {
                if let Some(p_char) = prev_char {
                    if c == p_char {
                        // Skip if the current character is the same as the previous one.
                        continue;
                    }
                }

                // If k is less than or equal to num_suffixes, it means the k-th string
                // starts with the current character 'c'.
                if k <= num_suffixes {
                    res_chars.push(c);
                    prev_char = Some(c);
                    break; // Move to the next position in the string.
                } else {
                    // If k is greater, subtract the count of strings starting with 'c'
                    // and continue to the next available character.
                    k -= num_suffixes;
                }
            }
        }

        res_chars.into_iter().collect()
    }
}
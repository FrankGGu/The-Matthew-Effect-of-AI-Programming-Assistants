impl Solution {
    pub fn license_key_formatting(s: String, k: i32) -> String {
        let k = k as usize;

        let cleaned_chars: Vec<char> = s
            .chars()
            .filter(|&c| c != '-')
            .map(|c| c.to_ascii_uppercase())
            .collect();

        let n = cleaned_chars.len();

        if n == 0 {
            return String::new();
        }

        // Calculate the length of the first group.
        // If n is a multiple of k, the first group has length k.
        // Otherwise, it has length n % k.
        // This can be concisely expressed as (n - 1) % k + 1 for n > 0.
        let first_group_len = (n - 1) % k + 1;

        // Pre-allocate capacity for the result string to avoid reallocations.
        // The number of dashes will be (n - 1) / k.
        let mut result = String::with_capacity(n + (n - 1) / k);

        // Append the first group
        for i in 0..first_group_len {
            result.push(cleaned_chars[i]);
        }

        // Append subsequent groups, each preceded by a dash
        let mut current_idx = first_group_len;
        while current_idx < n {
            result.push('-');
            for i in 0..k {
                result.push(cleaned_chars[current_idx + i]);
            }
            current_idx += k;
        }

        result
    }
}
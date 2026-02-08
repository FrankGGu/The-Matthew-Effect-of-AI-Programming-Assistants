impl Solution {
    pub fn largest_palindrome(n: i32) -> i32 {
        if n == 1 {
            return 9;
        }

        let max_factor = 10_u64.pow(n as u32) - 1;
        let min_factor = 10_u64.pow(n as u32 - 1);

        // Iterate through the first half of possible 2n-digit palindromes
        // from largest to smallest.
        // A 2n-digit palindrome can be constructed from its first n digits (i).
        // The palindrome will be i concatenated with reverse(i).
        // Example: n=2, i=99 -> 9999, i=98 -> 9889
        for i in (min_factor..=max_factor).rev() {
            let s_i = i.to_string();
            let s_rev_i = s_i.chars().rev().collect::<String>();
            let palindrome_str = format!("{}{}", s_i, s_rev_i);
            let p = palindrome_str.parse::<u64>().unwrap();

            // Check if p is a product of two n-digit numbers.
            // We need to find x, y such that p = x * y and min_factor <= x, y <= max_factor.
            // Iterate x downwards from max_factor.
            // The lower bound for x is max(min_factor, p / max_factor).
            // We also need x >= sqrt(p) to avoid duplicate pairs (x, y) and (y, x)
            // and to ensure y = p/x is not too large.
            // However, p / max_factor is a tighter lower bound for x than sqrt(p)
            // when p is close to max_factor * max_factor.
            // The loop for x should run from max_factor down to p / max_factor.
            // If x * y = p, then y = p / x. We need y >= min_factor, which means x <= p / min_factor.
            // So x should iterate from min(max_factor, p / min_factor) down to max(min_factor, (p as f64).sqrt() as u64).
            // A simpler, often sufficient, loop for x is from max_factor down to p / max_factor.
            // The constraint is that x and y must both be n-digit numbers.
            // So x <= max_factor.
            // And y = p / x must satisfy y >= min_factor. This implies x <= p / min_factor.
            // So x cannot be greater than p / min_factor.
            // The loop for x starts from max_factor and goes down.
            // The smallest x can be is min_factor.
            // Also, x must be at least p / max_factor for y to be at most max_factor.

            let mut x = max_factor;
            while x * x >= p { // Optimization: x * x >= p implies x >= sqrt(p)
                if p % x == 0 {
                    let y = p / x;
                    if y >= min_factor && y <= max_factor {
                        return (p % 1337) as i32;
                    }
                }
                x -= 1;
            }
        }

        // This line should theoretically not be reached if n is valid and a palindrome exists.
        // But Rust requires all code paths to return a value.
        // For n=1, 9 is returned directly. For n > 1, a palindrome is guaranteed to be found.
        0
    }
}
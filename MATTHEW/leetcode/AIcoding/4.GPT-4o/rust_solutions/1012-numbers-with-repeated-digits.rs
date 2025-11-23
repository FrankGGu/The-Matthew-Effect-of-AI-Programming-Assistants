impl Solution {
    pub fn num_dup_digits_at_most_n(n: i32) -> i32 {
        let s = n.to_string();
        let len = s.len();
        let mut res = 0;

        for i in 1..len {
            res += 9 * (1..=9).fold(1, |acc, j| acc * (10 - j)) / (10 - i + 1);
        }

        let mut seen = vec![false; 10];
        for (i, ch) in s.chars().enumerate() {
            let digit = ch.to_digit(10).unwrap() as usize;
            for j in 0..digit {
                if !seen[j] {
                    res += (9 - i) * (10 - i - 1).pow(len - i - 1);
                }
            }
            if seen[digit] {
                break;
            }
            seen[digit] = true;
            if i == len - 1 {
                res += 1;
            }
        }

        n - res
    }
}
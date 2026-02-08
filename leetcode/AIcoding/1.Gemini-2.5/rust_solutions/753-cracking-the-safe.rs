struct Solution;

impl Solution {
    pub fn cracking_the_safe(n: i32, k: i32) -> String {
        let mut ans = String::new();
        let mut visited: std::collections::HashSet<String> = std::collections::HashSet::new();

        for _ in 0..(n - 1) {
            ans.push('0');
        }

        Self::dfs(n, k, &mut ans, &mut visited);

        ans
    }

    fn dfs(n: i32, k: i32, ans: &mut String, visited: &mut std::collections::HashSet<String>) -> bool {
        if visited.len() == (k as usize).pow(n as u32) {
            return true;
        }

        let current_suffix = if n == 1 {
            String::new()
        } else {
            ans.chars().skip(ans.len() - (n as usize - 1)).collect()
        };

        for digit in (0..k).rev() {
            let new_digit_char = std::char::from_digit(digit as u32, 10).unwrap();

            let mut new_pin = current_suffix.clone();
            new_pin.push(new_digit_char);

            if !visited.contains(&new_pin) {
                visited.insert(new_pin.clone());
                ans.push(new_digit_char);

                if Self::dfs(n, k, ans, visited) {
                    return true;
                }

                ans.pop();
                visited.remove(&new_pin);
            }
        }

        false
    }
}
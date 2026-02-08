impl Solution {
    pub fn num_dup_digits_at_most_n(n: i32) -> i32 {
        let mut digits: Vec<i32> = Vec::new();
        let mut num = n;
        while num > 0 {
            digits.push(num % 10);
            num /= 10;
        }
        digits.reverse();

        let k = digits.len();
        let mut ans = 0;

        for i in 1..k {
            ans += 9 * Self::permutation(9, i - 1);
        }

        let mut seen: std::collections::HashSet<i32> = std::collections::HashSet::new();
        for i in 0..k {
            for j in (if i == 0 { 1 } else { 0 })..digits[i] {
                if !seen.contains(&j) {
                    ans += Self::permutation(10 - (i as i32 + 1), k as i32 - (i as i32 + 1));
                }
            }
            if seen.contains(&digits[i]) {
                return n as i32 - ans;
            }
            seen.insert(digits[i]);
        }

        n as i32 - ans
    }

    fn permutation(n: i32, k: i32) -> i32 {
        if k < 0 || k > n {
            return 0;
        }
        let mut res = 1;
        for i in 0..k {
            res *= n - i;
        }
        res
    }
}

struct Solution;
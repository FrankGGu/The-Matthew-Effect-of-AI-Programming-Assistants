impl Solution {
    pub fn is_additive_number(num: String) -> bool {
        let n = num.len();
        for i in 1..=n / 2 {
            for j in 1..= (n - i) / 2 {
                if Self::is_valid(&num, 0, i, j) {
                    return true;
                }
            }
        }
        false
    }

    fn is_valid(num: &str, start: usize, len1: usize, len2: usize) -> bool {
        if num.len() <= start + len1 + len2 {
            return false;
        }

        if (num[start..start + len1].len() > 1 && num.as_bytes()[start] == b'0') || (num[start + len1..start + len1 + len2].len() > 1 && num.as_bytes()[start + len1] == b'0'){
            return false;
        }

        let num1 = num[start..start + len1].parse::<i64>().unwrap();
        let num2 = num[start + len1..start + len1 + len2].parse::<i64>().unwrap();

        let sum = num1 + num2;
        let sum_str = sum.to_string();
        let sum_len = sum_str.len();

        if start + len1 + len2 + sum_len > num.len(){
            return false
        }

        if num[start + len1 + len2..].starts_with(&sum_str) {
            if start + len1 + len2 + sum_len == num.len() {
                return true;
            }
            return Self::is_valid(num, start + len1, len2, sum_len);
        } else {
            return false;
        }
    }
}

struct Solution;
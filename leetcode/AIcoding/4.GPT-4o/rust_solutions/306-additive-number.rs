impl Solution {
    pub fn is_additive_number(num: String) -> bool {
        let n = num.len();

        for i in 1..n {
            for j in i + 1..n {
                if Self::is_valid(&num, 0, i, j) {
                    return true;
                }
            }
        }

        false
    }

    fn is_valid(num: &str, start: usize, i: usize, j: usize) -> bool {
        let (first, second) = (&num[start..i], &num[i..j]);
        let mut sum = Self::add(&first, &second);
        let mut idx = j;

        while idx < num.len() {
            if !num[idx..].starts_with(&sum) {
                return false;
            }
            idx += sum.len();
            first = second;
            second = &sum;
            sum = Self::add(first, second);
        }

        true
    }

    fn add(num1: &str, num2: &str) -> String {
        let mut result = String::new();
        let mut carry = 0;
        let mut i = num1.len() as isize - 1;
        let mut j = num2.len() as isize - 1;

        while i >= 0 || j >= 0 || carry > 0 {
            let x = if i >= 0 { num1.as_bytes()[i as usize] - b'0' } else { 0 };
            let y = if j >= 0 { num2.as_bytes()[j as usize] - b'0' } else { 0 };
            let sum = x + y + carry;
            result.push((sum % 10 + b'0') as char);
            carry = sum / 10;
            i -= 1;
            j -= 1;
        }

        result.chars().rev().collect()
    }
}
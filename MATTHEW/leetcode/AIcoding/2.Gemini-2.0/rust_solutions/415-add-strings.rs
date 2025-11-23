impl Solution {
    pub fn add_strings(num1: String, num2: String) -> String {
        let mut num1 = num1.chars().rev().collect::<Vec<_>>();
        let mut num2 = num2.chars().rev().collect::<Vec<_>>();
        let mut carry = 0;
        let mut result = String::new();

        let mut i = 0;
        let mut j = 0;

        while i < num1.len() || j < num2.len() || carry > 0 {
            let digit1 = if i < num1.len() { num1[i] as i32 - '0' as i32 } else { 0 };
            let digit2 = if j < num2.len() { num2[j] as i32 - '0' as i32 } else { 0 };

            let sum = digit1 + digit2 + carry;
            carry = sum / 10;
            let digit = sum % 10;

            result.push_str(&digit.to_string());

            i += 1;
            j += 1;
        }

        result.chars().rev().collect::<String>()
    }
}
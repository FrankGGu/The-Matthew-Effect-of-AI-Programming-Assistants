impl Solution {
    pub fn num_steps(s: String) -> i32 {
        let mut steps = 0;
        let mut carry = 0;
        let mut chars: Vec<char> = s.chars().collect();

        for i in (1..chars.len()).rev() {
            let current = chars[i].to_digit(2).unwrap() as i32 + carry;
            if current % 2 == 1 {
                steps += 2;
                carry = 1;
            } else {
                steps += 1;
            }
        }

        steps + carry
    }
}
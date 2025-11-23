struct Solution {}

impl Solution {
    pub fn num_steps(mut s: String) -> i32 {
        let mut steps = 0;
        while s.len() > 1 {
            if s.chars().last() == Some('1') {
                steps += 1;
                let mut carry = 1;
                for i in (0..s.len()).rev() {
                    let bit = s.chars().nth(i).unwrap();
                    if carry == 1 {
                        if bit == '1' {
                            s.replace_range(i..i+1, "0");
                            carry = 1;
                        } else {
                            s.replace_range(i..i+1, "1");
                            carry = 0;
                        }
                    }
                }
                if carry == 1 {
                    s.insert(0, '1');
                }
            } else {
                steps += 1;
                s.pop();
            }
        }
        steps
    }
}
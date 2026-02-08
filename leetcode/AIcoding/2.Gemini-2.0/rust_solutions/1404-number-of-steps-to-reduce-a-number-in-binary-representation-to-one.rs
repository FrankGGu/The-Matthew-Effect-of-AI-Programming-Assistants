impl Solution {
    pub fn num_steps(s: String) -> i32 {
        let mut num = s.chars().collect::<Vec<char>>();
        let mut steps = 0;
        while num.len() > 1 {
            if num.last() == Some(&'0') {
                num.pop();
            } else {
                let mut carry = true;
                for i in (0..num.len()).rev() {
                    if carry {
                        if num[i] == '0' {
                            num[i] = '1';
                            carry = false;
                        } else {
                            num[i] = '0';
                        }
                    }
                }
                if carry {
                    num.insert(0, '1');
                }
            }
            steps += 1;
        }
        steps
    }
}
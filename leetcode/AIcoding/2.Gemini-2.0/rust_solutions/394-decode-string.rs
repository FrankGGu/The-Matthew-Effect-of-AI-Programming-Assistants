impl Solution {
    pub fn decode_string(s: String) -> String {
        let mut stack: Vec<(i32, String)> = Vec::new();
        let mut num = 0;
        let mut res = String::new();

        for c in s.chars() {
            match c {
                '[' => {
                    stack.push((num, res));
                    num = 0;
                    res = String::new();
                }
                ']' => {
                    let (prev_num, prev_res) = stack.pop().unwrap();
                    let mut temp = String::new();
                    for _ in 0..prev_num {
                        temp.push_str(&res);
                    }
                    res = prev_res + &temp;
                }
                '0'..='9' => {
                    num = num * 10 + c.to_digit(10).unwrap() as i32;
                }
                _ => {
                    res.push(c);
                }
            }
        }

        res
    }
}
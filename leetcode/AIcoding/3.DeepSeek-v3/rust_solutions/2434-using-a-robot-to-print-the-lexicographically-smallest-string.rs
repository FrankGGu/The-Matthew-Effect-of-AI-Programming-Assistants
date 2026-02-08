impl Solution {
    pub fn robot_with_string(s: String) -> String {
        let s = s.into_bytes();
        let n = s.len();
        let mut freq = vec![0; 26];
        for &c in &s {
            freq[(c - b'a') as usize] += 1;
        }

        let mut stack = Vec::new();
        let mut res = Vec::new();
        let mut min_char = 0;

        for &c in &s {
            stack.push(c);
            freq[(c - b'a') as usize] -= 1;

            while min_char < 26 && freq[min_char] == 0 {
                min_char += 1;
            }

            while !stack.is_empty() && stack.last().unwrap() - b'a' <= min_char as u8 {
                res.push(stack.pop().unwrap());
            }
        }

        while let Some(c) = stack.pop() {
            res.push(c);
        }

        String::from_utf8(res).unwrap()
    }
}
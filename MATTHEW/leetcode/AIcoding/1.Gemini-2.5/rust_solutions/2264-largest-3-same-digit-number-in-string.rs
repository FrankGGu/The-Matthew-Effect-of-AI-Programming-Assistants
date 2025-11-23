impl Solution {
    pub fn largest_good_integer(num: String) -> String {
        let bytes = num.as_bytes();
        let mut max_good_char: Option<char> = None;

        for i in 0..bytes.len() - 2 {
            let c1 = bytes[i] as char;
            let c2 = bytes[i + 1] as char;
            let c3 = bytes[i + 2] as char;

            if c1 == c2 && c2 == c3 {
                match max_good_char {
                    Some(max_char) => {
                        if c1 > max_char {
                            max_good_char = Some(c1);
                        }
                    }
                    None => {
                        max_good_char = Some(c1);
                    }
                }
            }
        }

        match max_good_char {
            Some(c) => {
                let s = c.to_string();
                format!("{}{}{}", s, s, s)
            }
            None => "".to_string(),
        }
    }
}
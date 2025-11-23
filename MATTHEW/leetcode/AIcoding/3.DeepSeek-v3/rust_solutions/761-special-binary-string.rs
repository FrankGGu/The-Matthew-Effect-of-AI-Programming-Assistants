impl Solution {
    pub fn make_largest_special(s: String) -> String {
        let mut res = Vec::new();
        let mut count = 0;
        let mut i = 0;
        let bytes = s.as_bytes();
        for j in 0..bytes.len() {
            if bytes[j] == b'1' {
                count += 1;
            } else {
                count -= 1;
            }
            if count == 0 {
                let mut sub = String::from("1");
                sub.push_str(&Solution::make_largest_special(
                    String::from_utf8(bytes[i + 1..j].to_vec()).unwrap()
                ));
                sub.push('0');
                res.push(sub);
                i = j + 1;
            }
        }
        res.sort_by(|a, b| b.cmp(a));
        res.join("")
    }
}
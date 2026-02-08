impl Solution {
    pub fn count_and_say(n: i32) -> String {
        let mut s = String::from("1");
        for _ in 1..n {
            let mut next_s = String::new();
            let mut count = 1;
            let mut prev = s.chars().next().unwrap();
            for c in s.chars().skip(1) {
                if c == prev {
                    count += 1;
                } else {
                    next_s.push_str(&count.to_string());
                    next_s.push(prev);
                    count = 1;
                    prev = c;
                }
            }
            next_s.push_str(&count.to_string());
            next_s.push(prev);
            s = next_s;
        }
        s
    }
}
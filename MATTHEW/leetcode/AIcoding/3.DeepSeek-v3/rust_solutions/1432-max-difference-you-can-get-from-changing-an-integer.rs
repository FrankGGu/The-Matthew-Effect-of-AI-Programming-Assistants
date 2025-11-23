impl Solution {
    pub fn max_diff(num: i32) -> i32 {
        let s = num.to_string();
        let mut max = num;
        let mut min = num;

        for x in '0'..='9' {
            for y in '0'..='9' {
                let t: String = s.chars().map(|c| if c == x { y } else { c }).collect();
                if t.starts_with('0') {
                    continue;
                }
                let val = t.parse::<i32>().unwrap();
                if val > max {
                    max = val;
                }
                if val < min {
                    min = val;
                }
            }
        }

        max - min
    }
}
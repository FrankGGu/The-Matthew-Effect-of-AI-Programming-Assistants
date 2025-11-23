struct Solution;

impl Solution {
    pub fn num_ways(s: String) -> i32 {
        let mut count = 0;
        let mut first = -1;
        let mut second = -1;
        for (i, c) in s.chars().enumerate() {
            if c == '1' {
                count += 1;
                if first == -1 {
                    first = i as i32;
                } else if second == -1 {
                    second = i as i32;
                }
            }
        }
        if count < 2 {
            return 0;
        }
        let mut res = 0;
        let mut i = first + 1;
        while i < second {
            res += 1;
            i += 1;
        }
        res
    }
}
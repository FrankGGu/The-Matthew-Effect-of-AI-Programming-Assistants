impl Solution {
    pub fn min_operations(s: String) -> i32 {
        let n = s.len();
        let mut count1 = 0;
        let mut count2 = 0;
        for (i, c) in s.chars().enumerate() {
            if i % 2 == 0 {
                if c == '1' {
                    count1 += 1;
                } else {
                    count2 += 1;
                }
            } else {
                if c == '0' {
                    count1 += 1;
                } else {
                    count2 += 1;
                }
            }
        }
        count1.min(count2)
    }
}
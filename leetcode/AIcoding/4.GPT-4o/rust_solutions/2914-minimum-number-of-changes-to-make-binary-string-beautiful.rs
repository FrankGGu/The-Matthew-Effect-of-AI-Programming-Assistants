impl Solution {
    pub fn minimum_beautiful_binary_string(s: String) -> i32 {
        let mut count = 0;
        let mut ones = 0;

        for c in s.chars() {
            if c == '1' {
                ones += 1;
            } else {
                if ones % 2 == 1 {
                    count += 1;
                }
                ones = 0;
            }
        }

        if ones % 2 == 1 {
            count += 1;
        }

        count
    }
}
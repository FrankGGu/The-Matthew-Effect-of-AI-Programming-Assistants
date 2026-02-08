impl Solution {
    pub fn min_operations(s: String) -> i32 {
        let mut count1 = 0;
        let mut count2 = 0;

        for (i, c) in s.chars().enumerate() {
            if (i % 2 == 0 && c == '1') || (i % 2 == 1 && c == '0') {
                count1 += 1;
            } else {
                count2 += 1;
            }
        }

        count1.min(count2)
    }
}
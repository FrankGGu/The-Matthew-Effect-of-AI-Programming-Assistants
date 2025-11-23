impl Solution {
    pub fn longest_awesome(s: String) -> i32 {
        let mut mask = 0;
        let mut first_occurrence = vec![-1; 1 << 10];
        first_occurrence[0] = 0;
        let mut max_len = 0;

        for (i, c) in s.chars().enumerate() {
            let digit = c.to_digit(10).unwrap() as usize;
            mask ^= 1 << digit;

            if first_occurrence[mask] != -1 {
                max_len = max_len.max(i as i32 - first_occurrence[mask] + 1);
            } else {
                first_occurrence[mask] = i as i32 + 1;
            }

            for d in 0..10 {
                let temp_mask = mask ^ (1 << d);
                if first_occurrence[temp_mask] != -1 {
                    max_len = max_len.max(i as i32 - first_occurrence[temp_mask] + 1);
                }
            }
        }

        max_len
    }
}
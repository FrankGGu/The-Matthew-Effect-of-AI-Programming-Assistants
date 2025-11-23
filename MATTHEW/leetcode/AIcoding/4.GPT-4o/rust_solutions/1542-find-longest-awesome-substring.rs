impl Solution {
    pub fn longest_awesome(s: String) -> i32 {
        let mut mask = 0;
        let mut max_len = 0;
        let mut first_occurrence = vec![-1; 1 << 10];
        first_occurrence[0] = 0;

        for (i, c) in s.chars().enumerate() {
            mask ^= 1 << (c as usize - '0' as usize);
            if first_occurrence[mask] == -1 {
                first_occurrence[mask] = i as i32 + 1;
            }
            max_len = max_len.max(i as i32 + 1 - first_occurrence[mask]);

            for j in 0..10 {
                let toggled_mask = mask ^ (1 << j);
                if first_occurrence[toggled_mask] != -1 {
                    max_len = max_len.max(i as i32 + 1 - first_occurrence[toggled_mask]);
                }
            }
        }

        max_len
    }
}
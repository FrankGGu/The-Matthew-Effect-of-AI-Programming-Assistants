impl Solution {
    pub fn alternating_groups(s: String) -> i32 {
        let bytes = s.as_bytes();
        let n = bytes.len();
        if n == 0 {
            return 0;
        }

        let mut max_len = 1;
        let mut curr_len = 1;
        let mut group = 0; // 0 for initial, 1 for first group, 2 for second group

        for i in 1..n {
            if bytes[i] == bytes[i - 1] {
                curr_len = 1;
                group = 0;
            } else {
                if group == 0 {
                    group = if bytes[i] == bytes[0] { 2 } else { 1 };
                    curr_len = 2;
                } else {
                    let expected_group = if bytes[i-1] == bytes[0] { 1 } else { 2 };
                    if group != expected_group {
                        curr_len += 1;
                        group = expected_group;
                    } else {
                        curr_len = 2;
                        group = if bytes[i] == bytes[0] { 2 } else { 1 };
                    }
                }

                max_len = max_len.max(curr_len);
            }
        }

        max_len
    }
}
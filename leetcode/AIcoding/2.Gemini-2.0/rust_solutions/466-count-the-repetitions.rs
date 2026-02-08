use std::collections::HashMap;

impl Solution {
    pub fn get_max_repetitions(s1: String, n1: i32, s2: String, n2: i32) -> i32 {
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();
        let len1 = s1_bytes.len();
        let len2 = s2_bytes.len();

        let mut repeat_count = 0;
        let mut j = 0;

        let mut seen: HashMap<usize, (i32, usize)> = HashMap::new();

        for i in 0..n1 {
            if seen.contains_key(&j) {
                let (prev_repeat_count, prev_i) = seen.get(&j).unwrap();
                let pattern_repeat = (repeat_count - prev_repeat_count) * ((n1 - prev_i) / (i - prev_i));
                repeat_count += pattern_repeat;
                let remaining = (n1 - prev_i) % (i - prev_i) + prev_i;
                for _ in prev_i..remaining {
                    for &b in s1_bytes {
                        if b == s2_bytes[j] {
                            j += 1;
                            if j == len2 {
                                repeat_count += 1;
                                j = 0;
                            }
                        }
                    }
                }
                break;
            }

            seen.insert(j, (repeat_count, i));

            for &b in s1_bytes {
                if b == s2_bytes[j] {
                    j += 1;
                    if j == len2 {
                        repeat_count += 1;
                        j = 0;
                    }
                }
            }
        }

        repeat_count / n2
    }
}
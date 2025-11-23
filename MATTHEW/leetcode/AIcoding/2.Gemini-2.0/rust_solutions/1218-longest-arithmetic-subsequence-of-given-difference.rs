use std::collections::HashMap;

impl Solution {
    pub fn longest_arith_seq_length(arr: Vec<i32>, difference: i32) -> i32 {
        let mut dp: HashMap<i32, HashMap<i32, i32>> = HashMap::new();
        let mut max_len = 1;

        for &num in &arr {
            if !dp.contains_key(&num) {
                dp.insert(num, HashMap::new());
            }

            for &prev_num in &arr {
                if prev_num < num {
                    let diff = num - prev_num;

                    if diff == difference {
                        let len = if dp.contains_key(&prev_num) && dp[&prev_num].contains_key(&0) {
                            dp[&prev_num][&0] + 1
                        } else {
                            2
                        };

                        if !dp[&num].contains_key(&0) || dp[&num][&0] < len {
                            dp.get_mut(&num).unwrap().insert(0, len);
                            max_len = max_len.max(len);
                        }
                    }
                }
            }

            if !dp[&num].contains_key(&0) {
                dp.get_mut(&num).unwrap().insert(0, 1);
            }
        }

        max_len
    }
}
impl Solution {
    pub fn max_length(arr: Vec<String>) -> i32 {
        let mut dp: Vec<u32> = vec![0];
        let mut ans = 0;

        for s in arr {
            let mask = Self::string_to_mask(&s);
            if mask == 0 {
                continue;
            }

            for i in (0..dp.len()).rev() {
                if (dp[i] & mask) == 0 {
                    dp.push(dp[i] | mask);
                    ans = ans.max((dp.last().unwrap().count_ones()) as i32);
                }
            }
        }

        ans
    }

    fn string_to_mask(s: &String) -> u32 {
        let mut mask: u32 = 0;
        for c in s.chars() {
            let bit = 1 << (c as u32 - 'a' as u32);
            if (mask & bit) > 0 {
                return 0;
            }
            mask |= bit;
        }
        mask
    }
}
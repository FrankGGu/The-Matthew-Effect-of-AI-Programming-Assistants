impl Solution {
    pub fn min_swaps(s: String) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let count1 = s_chars.iter().filter(|&&c| c == '1').count();
        let count0 = s_chars.len() - count1;

        if (count1 as i32 - count0 as i32).abs() > 1 {
            return -1;
        }

        let mut swaps1 = 0; // starts with '1'
        let mut swaps0 = 0; // starts with '0'

        for (i, &c) in s_chars.iter().enumerate() {
            let expected = if i % 2 == 0 { '1' } else { '0' };
            if c != expected {
                swaps1 += 1;
            }

            let expected = if i % 2 == 0 { '0' } else { '1' };
            if c != expected {
                swaps0 += 1;
            }
        }

        if count1 > count0 {
            swaps1 / 2
        } else if count0 > count1 {
            swaps0 / 2
        } else {
            std::cmp::min(swaps0, swaps1) / 2
        }
    }
}
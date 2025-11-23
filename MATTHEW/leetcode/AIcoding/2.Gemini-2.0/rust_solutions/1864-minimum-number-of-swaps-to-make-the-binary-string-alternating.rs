impl Solution {
    pub fn min_swaps(s: String) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();

        let mut count0 = 0;
        let mut count1 = 0;
        for &c in &chars {
            if c == '0' {
                count0 += 1;
            } else {
                count1 += 1;
            }
        }

        if (count0 - count1).abs() > 1 {
            return -1;
        }

        let mut swaps0 = 0;
        let mut swaps1 = 0;

        if count0 >= count1 {
            let mut temp0 = chars.clone();
            for i in 0..n {
                if i % 2 == 0 && temp0[i] != '0' {
                    swaps0 += 1;
                } else if i % 2 == 1 && temp0[i] != '1' {
                    swaps0 += 1;
                }
            }
        } else {
            swaps0 = i32::MAX;
        }

        if count1 >= count0 {
            let mut temp1 = chars.clone();
            for i in 0..n {
                if i % 2 == 0 && temp1[i] != '1' {
                    swaps1 += 1;
                } else if i % 2 == 1 && temp1[i] != '0' {
                    swaps1 += 1;
                }
            }
        } else {
            swaps1 = i32::MAX;
        }

        swaps0.min(swaps1)
    }
}
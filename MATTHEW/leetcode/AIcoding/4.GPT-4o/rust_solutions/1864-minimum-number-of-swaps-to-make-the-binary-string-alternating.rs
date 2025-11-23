impl Solution {
    pub fn min_swaps(s: String) -> i32 {
        let n = s.len();
        let count_1 = s.chars().filter(|&c| c == '1').count();
        let count_0 = n - count_1;

        if (count_1 + count_0) % 2 != 0 {
            return -1;
        }

        let target_1 = (count_1 + 1) / 2;
        let target_0 = (count_0 + 1) / 2;

        let mut swaps_0 = 0;
        let mut swaps_1 = 0;

        for i in 0..n {
            if i % 2 == 0 {
                if s.chars().nth(i).unwrap() == '1' {
                    swaps_1 += 1;
                }
                if s.chars().nth(i).unwrap() == '0' {
                    swaps_0 += 1;
                }
            } else {
                if s.chars().nth(i).unwrap() == '0' {
                    swaps_1 += 1;
                }
                if s.chars().nth(i).unwrap() == '1' {
                    swaps_0 += 1;
                }
            }
        }

        swaps_1.min(swaps_0)
    }
}
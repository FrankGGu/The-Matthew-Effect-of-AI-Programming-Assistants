impl Solution {
    pub fn num_ways(s: String) -> i32 {
        let count_ones = s.chars().filter(|&c| c == '1').count();
        if count_ones % 3 != 0 {
            return 0;
        }
        if count_ones == 0 {
            return ((s.len() - 1) * (s.len() - 2) / 2) as i32;
        }
        let target = count_ones / 3;
        let mut first_split = 0;
        let mut second_split = 0;
        let mut count = 0;
        for (i, c) in s.chars().enumerate() {
            if c == '1' {
                if first_split < target {
                    first_split += 1;
                } else if second_split < target {
                    second_split += 1;
                } else {
                    count += 1;
                }
            }
        }
        let mut first_ways = 0;
        let mut second_ways = 0;
        for c in s.chars() {
            if c == '1' {
                if first_split > 0 {
                    first_split -= 1;
                } else if second_split > 0 {
                    second_split -= 1;
                } else {
                    first_ways += 1;
                }
            }
            if first_split == 0 && second_split == 0 {
                return (count + 1) as i32;
            }
        }
        (first_ways + 1) * (second_ways + 1) % 1_000_000_007
    }
}
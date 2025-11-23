impl Solution {
    pub fn largest_variance(s: String) -> i32 {
        let s = s.as_bytes();
        let mut ans = 0;
        for i in 0..26 {
            for j in 0..26 {
                if i == j {
                    continue;
                }
                let mut max_so_far = -100000;
                let mut min_so_far = -100000;
                let mut count_i = 0;
                let mut count_j = 0;
                for &c in s {
                    if c as usize - 'a' as usize == i {
                        count_i += 1;
                    } else if c as usize - 'a' as usize == j {
                        count_j += 1;
                    }
                    if count_i > 0 && count_j > 0 {
                        max_so_far = max_so_far.max(count_i - count_j);
                        min_so_far = min_so_far.max(count_j - count_i);
                        ans = ans.max(max_so_far.max(min_so_far));
                    } else if count_i == 0 && count_j > 0 {
                        count_i = 0;
                        count_j = -1;
                    } else if count_j == 0 && count_i > 0 {
                        count_j = 0;
                        count_i = -1;
                    }
                }
            }
        }
        ans
    }
}
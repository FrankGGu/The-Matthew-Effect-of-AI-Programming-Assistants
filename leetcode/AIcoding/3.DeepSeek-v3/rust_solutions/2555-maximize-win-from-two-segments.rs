impl Solution {
    pub fn maximize_win(prize_positions: Vec<i32>, k: i32) -> i32 {
        let n = prize_positions.len();
        let k = k as usize;
        let mut prefix = vec![0; n + 1];
        let mut left = 0;
        for right in 0..n {
            while prize_positions[right] - prize_positions[left] > k as i32 {
                left += 1;
            }
            prefix[right + 1] = prefix[right].max((right - left + 1) as i32);
        }

        let mut suffix = vec![0; n + 1];
        let mut right = n - 1;
        for left in (0..n).rev() {
            while prize_positions[right] - prize_positions[left] > k as i32 {
                right -= 1;
            }
            suffix[left] = suffix[left + 1].max((right - left + 1) as i32);
        }

        let mut res = 0;
        for i in 0..=n {
            res = res.max(prefix[i] + suffix[i]);
        }
        res
    }
}
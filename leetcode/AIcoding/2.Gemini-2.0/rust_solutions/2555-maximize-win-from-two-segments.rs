impl Solution {
    pub fn maximize_win(prize_positions: Vec<i32>, k: i32) -> i32 {
        let n = prize_positions.len();
        let mut ans = 0;
        let mut j = 0;
        for i in 0..n {
            while j < n && prize_positions[j] - prize_positions[i] <= k {
                j += 1;
            }
            ans = ans.max((j - i) as i32);
        }

        let mut max_left = vec![0; n];
        let mut l = 0;
        let mut r = 0;
        for i in 0..n {
            while r < n && prize_positions[r] - prize_positions[i] <= k {
                r += 1;
            }
            max_left[i] = (r - i) as i32;
        }

        let mut max_right = vec![0; n];
        l = n as i32 - 1;
        r = n as i32 - 1;
        for i in (0..n).rev() {
            while l >= 0 && prize_positions[i] - prize_positions[l as usize] <= k {
                l -= 1;
            }
            max_right[i] = (i as i32 - l - 1) as i32;
        }

        let mut suffix_max = vec![0; n + 1];
        suffix_max[n] = 0;
        for i in (0..n).rev() {
            suffix_max[i] = suffix_max[i + 1].max(max_right[i]);
        }

        let mut res = 0;
        for i in 0..n - 1 {
            res = res.max(max_left[i] + suffix_max[i + 1]);
        }

        res
    }
}
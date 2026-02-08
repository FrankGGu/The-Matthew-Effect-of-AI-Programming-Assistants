impl Solution {
    pub fn smallest_sequence(n: i32) -> Vec<i32> {
        let mut ans = vec![0; 2 * n as usize - 1];
        let mut used = vec![false; n as usize + 1];

        fn solve(idx: usize, n: i32, ans: &mut Vec<i32>, used: &mut Vec<bool>) -> bool {
            if idx == ans.len() {
                return true;
            }

            for i in (1..=n).rev() {
                if used[i as usize] {
                    continue;
                }

                if i == 1 {
                    ans[idx] = i;
                    used[i as usize] = true;
                    if solve(idx + 1, n, ans, used) {
                        return true;
                    }
                    used[i as usize] = false;
                    ans[idx] = 0;
                } else if idx + i as usize < ans.len() && ans[idx + i as usize] == 0 {
                    ans[idx] = i;
                    ans[idx + i as usize] = i;
                    used[i as usize] = true;

                    if solve(idx + 1, n, ans, used) {
                        return true;
                    }

                    used[i as usize] = false;
                    ans[idx] = 0;
                    ans[idx + i as usize] = 0;
                }
            }
            false
        }

        solve(0, n, &mut ans, &mut used);
        ans
    }
}
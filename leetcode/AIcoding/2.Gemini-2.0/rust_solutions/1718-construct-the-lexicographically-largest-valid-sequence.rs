impl Solution {
    pub fn construct_distanced_sequence(n: i32) -> Vec<i32> {
        let mut ans = vec![0; 2 * n as usize - 1];
        let mut used = vec![false; n as usize + 1];

        fn solve(ans: &mut Vec<i32>, used: &mut Vec<bool>, n: i32, idx: usize) -> bool {
            if idx == ans.len() {
                return true;
            }

            if ans[idx] != 0 {
                return solve(ans, used, n, idx + 1);
            }

            for i in (1..=n).rev() {
                if !used[i as usize] {
                    if i == 1 {
                        ans[idx] = i;
                        used[i as usize] = true;
                        if solve(ans, used, n, idx + 1) {
                            return true;
                        }
                        used[i as usize] = false;
                        ans[idx] = 0;
                    } else if idx + i as usize < ans.len() && ans[idx + i as usize] == 0 {
                        ans[idx] = i;
                        ans[idx + i as usize] = i;
                        used[i as usize] = true;
                        if solve(ans, used, n, idx + 1) {
                            return true;
                        }
                        used[i as usize] = false;
                        ans[idx] = 0;
                        ans[idx + i as usize] = 0;
                    }
                }
            }

            false
        }

        solve(&mut ans, &mut used, n, 0);

        ans
    }
}
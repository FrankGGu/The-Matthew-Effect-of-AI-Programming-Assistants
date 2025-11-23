impl Solution {
    pub fn distribute_cookies(cookies: Vec<i32>, k: i32) -> i32 {
        let mut ans = i32::MAX;
        let mut distribution = vec![0; k as usize];
        let n = cookies.len();

        fn backtrack(cookies: &Vec<i32>, k: usize, distribution: &mut Vec<i32>, idx: usize, ans: &mut i32) {
            if idx == cookies.len() {
                let max_cookies = *distribution.iter().max().unwrap();
                *ans = (*ans).min(max_cookies);
                return;
            }

            for i in 0..k {
                distribution[i as usize] += cookies[idx];
                backtrack(cookies, k, distribution, idx + 1, ans);
                distribution[i as usize] -= cookies[idx];
            }
        }

        backtrack(&cookies, k as usize, &mut distribution, 0, &mut ans);
        ans
    }
}
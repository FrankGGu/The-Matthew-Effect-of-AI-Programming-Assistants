struct Solution;

impl Solution {
    pub fn distribute_cookies(cookies: Vec<i32>, k: i32) -> i32 {
        let k_usize = k as usize;
        let mut children_cookies = vec![0; k_usize];
        let mut min_unfairness = i32::MAX;

        Solution::dfs_helper(
            &cookies,
            0,
            &mut children_cookies,
            &mut min_unfairness,
            k_usize,
        );

        min_unfairness
    }

    fn dfs_helper(
        cookies: &Vec<i32>,
        cookie_idx: usize,
        children_cookies: &mut Vec<i32>,
        min_unfairness: &mut i32,
        k_usize: usize,
    ) {
        if cookie_idx == cookies.len() {
            let current_max_unfairness = *children_cookies.iter().max().unwrap();
            *min_unfairness = (*min_unfairness).min(current_max_unfairness);
            return;
        }

        for i in 0..k_usize {
            children_cookies[i] += cookies[cookie_idx];

            if children_cookies[i] >= *min_unfairness {
                children_cookies[i] -= cookies[cookie_idx];
                continue;
            }

            Solution::dfs_helper(
                cookies,
                cookie_idx + 1,
                children_cookies,
                min_unfairness,
                k_usize,
            );

            children_cookies[i] -= cookies[cookie_idx];

            if children_cookies[i] == 0 {
                break;
            }
        }
    }
}
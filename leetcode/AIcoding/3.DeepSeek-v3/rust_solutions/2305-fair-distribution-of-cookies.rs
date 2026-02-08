impl Solution {
    pub fn distribute_cookies(cookies: Vec<i32>, k: i32) -> i32 {
        let mut distribution = vec![0; k as usize];
        let mut min_unfairness = i32::MAX;
        Self::backtrack(0, &cookies, &mut distribution, &mut min_unfairness);
        min_unfairness
    }

    fn backtrack(
        idx: usize,
        cookies: &Vec<i32>,
        distribution: &mut Vec<i32>,
        min_unfairness: &mut i32,
    ) {
        if idx == cookies.len() {
            let max = *distribution.iter().max().unwrap();
            if max < *min_unfairness {
                *min_unfairness = max;
            }
            return;
        }

        for i in 0..distribution.len() {
            if distribution[i] + cookies[idx] >= *min_unfairness {
                continue;
            }
            distribution[i] += cookies[idx];
            Self::backtrack(idx + 1, cookies, distribution, min_unfairness);
            distribution[i] -= cookies[idx];
            if distribution[i] == 0 {
                break;
            }
        }
    }
}
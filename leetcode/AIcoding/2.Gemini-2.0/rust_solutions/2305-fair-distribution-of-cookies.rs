impl Solution {
    pub fn distribute_cookies(cookies: Vec<i32>, k: i32) -> i32 {
        let n = cookies.len();
        let k = k as usize;
        let mut bags = vec![0; k];
        let mut min_unfairness = i32::MAX;

        fn solve(cookies: &Vec<i32>, index: usize, bags: &mut Vec<i32>, min_unfairness: &mut i32) {
            if index == cookies.len() {
                *min_unfairness = (*min_unfairness).min(*bags.iter().max().unwrap());
                return;
            }

            for i in 0..bags.len() {
                bags[i] += cookies[index];
                solve(cookies, index + 1, bags, min_unfairness);
                bags[i] -= cookies[index];
            }
        }

        solve(&cookies, 0, &mut bags, &mut min_unfairness);
        min_unfairness
    }
}
pub fn max_result(nums: Vec<i32>, k: i32) -> i32 {
    use std::collections::VecDeque;
    let n = nums.len();
    let mut dp = vec![0; n];
    dp[0] = nums[0];
    let mut deque = VecDeque::new();
    deque.push_back(0);

    for i in 1..n {
        while let Some(&j) = deque.front() {
            if j < i - k as usize {
                deque.pop_front();
            } else {
                break;
            }
        }
        dp[i] = dp[*deque.front().unwrap()] + nums[i];
        while let Some(&j) = deque.back() {
            if dp[j] <= dp[i] {
                deque.pop_back();
            } else {
                break;
            }
        }
        deque.push_back(i);
    }
    dp[n - 1]
}
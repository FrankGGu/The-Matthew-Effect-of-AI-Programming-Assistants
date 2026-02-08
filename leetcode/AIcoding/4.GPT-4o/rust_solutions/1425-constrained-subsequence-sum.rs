pub fn constrained_subsequence_sum(nums: Vec<i32>, k: i32) -> i32 {
    let n = nums.len();
    let mut dp = vec![0; n];
    let mut deque = std::collections::VecDeque::new();

    for i in 0..n {
        dp[i] = nums[i] + if let Some(&j) = deque.front() { dp[j as usize] } else { 0 };

        while let Some(&j) = deque.back() {
            if dp[j as usize] <= dp[i] {
                deque.pop_back();
            } else {
                break;
            }
        }

        deque.push_back(i as i32);

        if i as i32 - deque.front().unwrap() >= k {
            deque.pop_front();
        }
    }

    *dp.iter().max().unwrap()
}
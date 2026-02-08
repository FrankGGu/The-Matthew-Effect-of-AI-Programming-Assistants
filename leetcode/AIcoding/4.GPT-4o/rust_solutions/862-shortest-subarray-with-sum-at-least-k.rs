use std::collections::VecDeque;

pub fn shortest_subarray(nums: Vec<i32>, k: i32) -> i32 {
    let n = nums.len();
    let mut prefix_sum = vec![0; n + 1];
    for i in 0..n {
        prefix_sum[i + 1] = prefix_sum[i] + nums[i];
    }

    let mut min_length = std::i32::MAX;
    let mut deque = VecDeque::new();

    for i in 0..=n {
        while let Some(&j) = deque.front() {
            if prefix_sum[i] - prefix_sum[j] >= k {
                min_length = min_length.min((i - j) as i32);
                deque.pop_front();
            } else {
                break;
            }
        }

        while let Some(&j) = deque.back() {
            if prefix_sum[j] > prefix_sum[i] {
                deque.pop_back();
            } else {
                break;
            }
        }

        deque.push_back(i);
    }

    if min_length == std::i32::MAX {
        -1
    } else {
        min_length
    }
}
use std::collections::VecDeque;

pub fn shortest_subarray(nums: Vec<i32>, k: i32) -> i32 {
    let n = nums.len();
    let mut prefix = vec![0; n + 1];
    for i in 0..n {
        prefix[i + 1] = prefix[i] | nums[i];
    }

    let mut min_length = n + 1;
    let mut deque = VecDeque::new();

    for i in 0..=n {
        while let Some(&j) = deque.back() {
            if prefix[j] | prefix[i] >= k {
                min_length = min_length.min(i - j);
                deque.pop_back();
            } else {
                break;
            }
        }
        while let Some(&j) = deque.front() {
            if j < i && prefix[j] | prefix[i] < k {
                deque.pop_front();
            } else {
                break;
            }
        }
        deque.push_back(i);
    }

    if min_length == n + 1 { -1 } else { min_length as i32 }
}
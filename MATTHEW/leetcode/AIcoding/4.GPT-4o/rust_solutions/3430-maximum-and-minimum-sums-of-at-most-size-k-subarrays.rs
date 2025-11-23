use std::collections::VecDeque;

pub fn max_sum_k_subarray(arr: Vec<i32>, k: usize) -> i32 {
    let n = arr.len();
    let mut max_sum = i32::MIN;
    let mut min_sum = i32::MAX;

    let mut max_deque: VecDeque<usize> = VecDeque::new();
    let mut min_deque: VecDeque<usize> = VecDeque::new();

    let mut current_sum = 0;

    for i in 0..n {
        current_sum += arr[i];

        while !max_deque.is_empty() && arr[max_deque.back().unwrap()] <= arr[i] {
            max_deque.pop_back();
        }
        max_deque.push_back(i);

        while !min_deque.is_empty() && arr[min_deque.back().unwrap()] >= arr[i] {
            min_deque.pop_back();
        }
        min_deque.push_back(i);

        if i >= k - 1 {
            if let Some(&front) = max_deque.front() {
                max_sum = max_sum.max(current_sum);
            }
            if let Some(&front) = min_deque.front() {
                min_sum = min_sum.min(current_sum);
            }
            current_sum -= arr[i - k + 1];
            if max_deque.front() == Some(&(i - k + 1)) {
                max_deque.pop_front();
            }
            if min_deque.front() == Some(&(i - k + 1)) {
                min_deque.pop_front();
            }
        }
    }

    (max_sum, min_sum)
}
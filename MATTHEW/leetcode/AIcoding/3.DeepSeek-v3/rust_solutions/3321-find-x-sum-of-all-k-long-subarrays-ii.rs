use std::collections::VecDeque;

impl Solution {
    pub fn get_xor_sum(arr: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let n = arr.len();
        let mut res = vec![0; n - k + 1];
        let mut xor = 0;
        let mut deque = VecDeque::new();

        for i in 0..n {
            if i >= k {
                let left = i - k;
                xor ^= arr[left];
                while !deque.is_empty() && deque.front() == Some(&left) {
                    deque.pop_front();
                }
            }
            while !deque.is_empty() && arr[*deque.back().unwrap()] <= arr[i] {
                deque.pop_back();
            }
            deque.push_back(i);
            xor ^= arr[i];
            if i >= k - 1 {
                res[i - k + 1] = xor ^ arr[*deque.front().unwrap()];
            }
        }
        res
    }
}
use std::collections::HashMap;

impl Solution {
    pub fn min_sum_of_lengths(arr: Vec<i32>, target: i32) -> i32 {
        let n = arr.len();
        let mut left = vec![i32::MAX; n];
        let mut right = vec![i32::MAX; n];
        let mut map = HashMap::new();
        map.insert(0, -1);
        let mut sum = 0;
        let mut min_len = i32::MAX;
        for i in 0..n {
            sum += arr[i];
            if let Some(&index) = map.get(&(sum - target)) {
                min_len = min_len.min((i as i32) - index);
            }
            map.insert(sum, i as i32);
            left[i] = min_len;
        }
        map.clear();
        map.insert(0, n as i32);
        sum = 0;
        min_len = i32::MAX;
        for i in (0..n).rev() {
            sum += arr[i];
            if let Some(&index) = map.get(&(sum - target)) {
                min_len = min_len.min(index - (i as i32));
            }
            map.insert(sum, i as i32);
            right[i] = min_len;
        }
        let mut ans = i32::MAX;
        for i in 0..n - 1 {
            if left[i] != i32::MAX && right[i + 1] != i32::MAX {
                ans = ans.min(left[i] + right[i + 1]);
            }
        }
        if ans == i32::MAX {
            -1
        } else {
            ans
        }
    }
}
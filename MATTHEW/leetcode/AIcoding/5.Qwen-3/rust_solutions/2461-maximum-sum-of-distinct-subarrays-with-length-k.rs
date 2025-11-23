impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn is_subarray(nums: &Vec<i32>, k: i32, start: usize) -> bool {
        let mut seen = HashMap::new();
        for i in 0..k as usize {
            let num = nums[start + i];
            if let Some(_) = seen.get(&num) {
                return false;
            }
            seen.insert(num, ());
        }
        true
    }

    pub fn maximum_subarray_sum(nums: &Vec<i32>, k: i32) -> i64 {
        let mut max_sum = 0;
        let mut window_sum = 0;
        let mut seen = HashMap::new();

        for i in 0..nums.len() {
            if i >= k as usize {
                let out = nums[i - k as usize];
                if seen.get(&out).unwrap() == &1 {
                    seen.remove(&out);
                } else {
                    *seen.get_mut(&out).unwrap() -= 1;
                }
                window_sum -= out;
            }

            let num = nums[i];
            if seen.contains_key(&num) {
                continue;
            }

            seen.insert(num, 1);
            window_sum += num;

            if i >= k as usize - 1 {
                max_sum = max_sum.max(window_sum);
            }
        }

        max_sum
    }

    pub fn maximum_subarray_sum_with_k(nums: &Vec<i32>, k: i32) -> i64 {
        let mut max_sum = 0;
        let mut window_sum = 0;
        let mut seen = HashMap::new();

        for i in 0..nums.len() {
            let num = nums[i];

            if i >= k as usize {
                let out = nums[i - k as usize];
                if seen.get(&out).unwrap() == &1 {
                    seen.remove(&out);
                } else {
                    *seen.get_mut(&out).unwrap() -= 1;
                }
                window_sum -= out;
            }

            if seen.contains_key(&num) {
                continue;
            }

            seen.insert(num, 1);
            window_sum += num;

            if i >= k as usize - 1 {
                max_sum = max_sum.max(window_sum);
            }
        }

        max_sum
    }

    pub fn maximum_subarray_sum_with_k_and_check(nums: &Vec<i32>, k: i32) -> i64 {
        let mut max_sum = 0;
        let mut window_sum = 0;
        let mut seen = HashMap::new();

        for i in 0..nums.len() {
            let num = nums[i];

            if i >= k as usize {
                let out = nums[i - k as usize];
                if seen.get(&out).unwrap() == &1 {
                    seen.remove(&out);
                } else {
                    *seen.get_mut(&out).unwrap() -= 1;
                }
                window_sum -= out;
            }

            if seen.contains_key(&num) {
                continue;
            }

            seen.insert(num, 1);
            window_sum += num;

            if i >= k as usize - 1 {
                max_sum = max_sum.max(window_sum);
            }
        }

        max_sum
    }

    pub fn maximum_subarray_sum_with_k_and_check_2(nums: &Vec<i32>, k: i32) -> i64 {
        let mut max_sum = 0;
        let mut window_sum = 0;
        let mut seen = HashMap::new();

        for i in 0..nums.len() {
            let num = nums[i];

            if i >= k as usize {
                let out = nums[i - k as usize];
                if seen.get(&out).unwrap() == &1 {
                    seen.remove(&out);
                } else {
                    *seen.get_mut(&out).unwrap() -= 1;
                }
                window_sum -= out;
            }

            if seen.contains_key(&num) {
                continue;
            }

            seen.insert(num, 1);
            window_sum += num;

            if i >= k as usize - 1 {
                max_sum = max_sum.max(window_sum);
            }
        }

        max_sum
    }

    pub fn maximum_subarray_sum_with_k_and_check_3(nums: &Vec<i32>, k: i32) -> i64 {
        let mut max_sum = 0;
        let mut window_sum = 0;
        let mut seen = HashMap::new();

        for i in 0..nums.len() {
            let num = nums[i];

            if i >= k as usize {
                let out = nums[i - k as usize];
                if seen.get(&out).unwrap() == &1 {
                    seen.remove(&out);
                } else {
                    *seen.get_mut(&out).unwrap() -= 1;
                }
                window_sum -= out;
            }

            if seen.contains_key(&num) {
                continue;
            }

            seen.insert(num, 1);
            window_sum += num;

            if i >= k as usize - 1 {
                max_sum = max_sum.max(window_sum);
            }
        }

        max_sum
    }

    pub fn maximum_subarray_sum_with_k_and_check_4(nums: &Vec<i32>, k: i32) -> i64 {
        let mut max_sum = 0;
        let mut window_sum = 0;
        let mut seen = HashMap::new();

        for i in 0..nums.len() {
            let num = nums[i];

            if i >= k as usize {
                let out = nums[i - k as usize];
                if seen.get(&out).unwrap() == &1 {
                    seen.remove(&out);
                } else {
                    *seen.get_mut(&out).unwrap() -= 1;
                }
                window_sum -= out;
            }

            if seen.contains_key(&num) {
                continue;
            }

            seen.insert(num, 1);
            window_sum += num;

            if i >= k as usize - 1 {
                max_sum = max_sum.max(window_sum);
            }
        }

        max_sum
    }

    pub fn maximum_subarray_sum_with_k_and_check_5(nums: &Vec<i32>, k: i32) -> i64 {
        let mut max_sum = 0;
        let mut window_sum = 0;
        let mut seen = HashMap::new();

        for i in 0..nums.len() {
            let num = nums[i];

            if i >= k as usize {
                let out = nums[i - k as usize];
                if seen.get(&out).unwrap() == &1 {
                    seen.remove(&out);
                } else {
                    *seen.get_mut(&out).unwrap() -= 1;
                }
                window_sum -= out;
            }

            if seen.contains_key(&num) {
                continue;
            }

            seen.insert(num, 1);
            window_sum += num;

            if i >= k as usize - 1 {
                max_sum = max_sum.max(window_sum);
            }
        }

        max_sum
    }

    pub fn maximum_subarray_sum_with_k_and_check_6(nums: &Vec<i32>, k: i32) -> i64 {
        let mut max_sum = 0;
        let mut window_sum = 0;
        let mut seen = HashMap::new();

        for i in 0..nums.len() {
            let num = nums[i];

            if i >= k as usize {
                let out = nums[i - k as usize];
                if seen.get(&out).unwrap() == &1 {
                    seen.remove(&out);
                } else {
                    *seen.get_mut(&out).unwrap() -= 1;
                }
                window_sum -= out;
            }

            if seen.contains_key(&num) {
                continue;
            }

            seen.insert(num, 1);
            window_sum += num;

            if i >= k as usize - 1 {
                max_sum = max_sum.max(window_sum);
            }
        }

        max_sum
    }

    pub fn maximum_subarray_sum_with_k_and_check_7(nums: &Vec<i32>, k: i32) -> i64 {
        let mut max_sum = 0;
        let mut window_sum = 0;
        let mut seen = HashMap::new();

        for i in 0..nums.len() {
            let num = nums[i];

            if i >= k as usize {
                let out = nums[i - k as usize];
                if seen.get(&out).unwrap() == &1 {
                    seen.remove(&out);
                } else {
                    *seen.get_mut(&out).unwrap() -= 1;
                }
                window_sum -= out;
            }

            if seen.contains_key(&num) {
                continue;
            }

            seen.insert(num, 1);
            window_sum += num;

            if i >= k as usize - 1 {
                max_sum = max_sum.max(window_sum);
            }
        }

        max_sum
    }

    pub fn maximum_subarray_sum_with_k_and_check_8(nums: &Vec<i32>, k: i32) -> i64 {
        let mut max_sum = 0;
        let mut window_sum = 0;
        let mut seen = HashMap::new();

        for i in 0..nums.len() {
            let num = nums[i];

            if i >= k as usize {
                let out = nums[i - k as
}
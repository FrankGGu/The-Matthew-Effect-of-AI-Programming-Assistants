use std::collections::BTreeSet;

impl Solution {
    pub fn minimum_cost(nums: Vec<i32>, k: i32, dist: i32) -> i64 {
        let k = k as usize;
        let dist = dist as usize;
        let n = nums.len();
        let mut res = i64::MAX;
        let mut sum = 0i64;
        let mut left = BTreeSet::new();
        let mut right = BTreeSet::new();

        for i in 1..=dist + 1 {
            left.insert((nums[i], i));
            sum += nums[i] as i64;
            if left.len() > k - 1 {
                let &max = left.iter().rev().next().unwrap();
                left.remove(&max);
                sum -= max.0 as i64;
                right.insert(max);
            }
        }
        res = res.min(sum);

        for i in dist + 2..n {
            let val = nums[i];
            if !right.is_empty() && val < right.iter().next().unwrap().0 {
                left.insert((val, i));
                sum += val as i64;
            } else {
                right.insert((val, i));
            }

            let prev = i - dist - 1;
            let prev_val = nums[prev];
            if left.contains(&(prev_val, prev)) {
                left.remove(&(prev_val, prev));
                sum -= prev_val as i64;
            } else {
                right.remove(&(prev_val, prev));
            }

            while left.len() < k - 1 && !right.is_empty() {
                let &min = right.iter().next().unwrap();
                right.remove(&min);
                left.insert(min);
                sum += min.0 as i64;
            }
            while left.len() > k - 1 {
                let &max = left.iter().rev().next().unwrap();
                left.remove(&max);
                sum -= max.0 as i64;
                right.insert(max);
            }

            res = res.min(sum);
        }

        res + nums[0] as i64
    }
}
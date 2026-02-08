impl Solution {
    pub fn max_even_sum(mut nums: Vec<i32>, k: i32) -> i64 {
        nums.sort_unstable_by(|a, b| b.cmp(a));

        let k_usize = k as usize;
        let mut initial_sum: i64 = 0;

        for i in 0..k_usize {
            initial_sum += nums[i] as i64;
        }

        if initial_sum % 2 == 0 {
            return initial_sum;
        }

        let mut max_even_sum: i64 = -1;

        let mut min_odd_in_k: Option<i32> = None;
        let mut min_even_in_k: Option<i32> = None;

        let mut max_odd_not_in_k: Option<i32> = None;
        let mut max_even_not_in_k: Option<i32> = None;

        for i in (0..k_usize).rev() {
            if nums[i] % 2 != 0 {
                if min_odd_in_k.is_none() {
                    min_odd_in_k = Some(nums[i]);
                }
            } else {
                if min_even_in_k.is_none() {
                    min_even_in_k = Some(nums[i]);
                }
            }
            if min_odd_in_k.is_some() && min_even_in_k.is_some() {
                break;
            }
        }

        for i in k_usize..nums.len() {
            if nums[i] % 2 != 0 {
                if max_odd_not_in_k.is_none() {
                    max_odd_not_in_k = Some(nums[i]);
                }
            } else {
                if max_even_not_in_k.is_none() {
                    max_even_not_in_k = Some(nums[i]);
                }
            }
            if max_odd_not_in_k.is_some() && max_even_not_in_k.is_some() {
                break;
            }
        }

        if let (Some(min_odd), Some(max_even)) = (min_odd_in_k, max_even_not_in_k) {
            let sum1 = initial_sum - min_odd as i64 + max_even as i64;
            max_even_sum = max_even_sum.max(sum1);
        }

        if let (Some(min_even), Some(max_odd)) = (min_even_in_k, max_odd_not_in_k) {
            let sum2 = initial_sum - min_even as i64 + max_odd as i64;
            max_even_sum = max_even_sum.max(sum2);
        }

        max_even_sum
    }
}
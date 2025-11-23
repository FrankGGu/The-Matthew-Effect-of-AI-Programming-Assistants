impl Solution {
    pub fn max_strength(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let k = k as usize;
        let mut nums = nums;
        nums.sort();
        let mut ans: i64 = 1;
        let mut neg_count = 0;
        for &num in &nums {
            if num < 0 {
                neg_count += 1;
            }
        }

        if k == 0 {
            if nums.contains(&0) {
                return 0;
            } else {
                let mut max_val = i32::min_value();
                for &num in &nums {
                    max_val = max_val.max(num);
                }
                return max_val as i64;
            }
        }

        let mut i = n - 1;
        let mut cnt = k;
        while cnt > 0 {
            if nums[i] == 0 {
                return 0;
            }

            if nums[i] > 0 {
                ans *= nums[i] as i64;
                i -= 1;
                cnt -= 1;
            } else {
                if neg_count < 2 && cnt == k && k as usize == n {
                    return nums[i] as i64;
                }

                if neg_count < 2 && cnt == k && k as usize < n && nums[i] < 0 && i > 0 && nums[i-1] > 0 {
                    return 0;
                }

                if neg_count < 2 && cnt == 1 {
                    if i >= 1 {
                        if nums[i-1] > 0 {
                            return nums[i-1] as i64;
                        } else {
                            return nums[i] as i64;
                        }
                    } else {
                         return nums[i] as i64;
                    }
                }

                if i > 0 && nums[i - 1] < 0 {
                    ans *= (nums[i] * nums[i - 1]) as i64;
                    i -= 2;
                    cnt -= 1;
                    neg_count -= 2;
                } else {
                    if ans == 1 {
                        return 0;
                    }
                    return ans;
                }
            }
        }

        ans
    }
}
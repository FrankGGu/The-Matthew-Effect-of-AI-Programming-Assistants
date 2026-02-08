impl Solution {
    pub fn four_sum(nums: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut res: Vec<Vec<i32>> = Vec::new();

        for i in 0..n {
            if i > 0 && nums[i] == nums[i - 1] {
                continue;
            }
            for j in (i + 1)..n {
                if j > i + 1 && nums[j] == nums[j - 1] {
                    continue;
                }
                let mut left = j + 1;
                let mut right = n - 1;
                while left < right {
                    let sum = nums[i] as i64 + nums[j] as i64 + nums[left] as i64 + nums[right] as i64;
                    if sum == target as i64 {
                        res.push(vec![nums[i], nums[j], nums[left], nums[right]]);
                        while left < right && nums[left] == nums[left + 1] {
                            left += 1;
                        }
                        while left < right && nums[right] == nums[right - 1] {
                            right -= 1;
                        }
                        left += 1;
                        right -= 1;
                    } else if sum < target as i64 {
                        left += 1;
                    } else {
                        right -= 1;
                    }
                }
            }
        }

        res
    }
}
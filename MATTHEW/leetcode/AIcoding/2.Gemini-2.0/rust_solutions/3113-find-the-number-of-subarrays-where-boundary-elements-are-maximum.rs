impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let mut count = 0;
        let n = nums.len();
        for i in 0..n {
            for j in i..n {
                let mut max_val = i32::MIN;
                for l in i..=j {
                    max_val = max_val.max(nums[l]);
                }
                if nums[i] == k && nums[j] == k && max_val == k {
                    count += 1;
                }
                if nums[i] == k && i == j && max_val == k {
                    count += 1;
                }
                if nums[j] == k && i == j && max_val == k {
                    count += 1;
                }
                let mut max_value = i32::MIN;
                for l in i..=j{
                    max_value = max_value.max(nums[l]);
                }

                if max_value == k && nums[i] == k && nums[j] == k{
                    count +=1;
                }

                if max_value == k && i == j && nums[i] == k{
                    count += 1;
                }

                let mut max_check = i32::MIN;
                for l in i..=j{
                    max_check = max_check.max(nums[l]);
                }

                 if nums[i] == k && nums[j] == k && max_check == k {
                    count += 1;
                }
            }
        }

        let mut final_count = 0;

        for i in 0..n{
            for j in i..n{
                let mut max_val = i32::MIN;
                for l in i..=j{
                    max_val = max_val.max(nums[l]);
                }

                if max_val == k && nums[i] == k && nums[j] == k{
                    final_count += 1;
                }
            }
        }

        let mut ans = 0;
        for i in 0..n {
            for j in i..n {
                let mut max_val = i32::MIN;
                for l in i..=j{
                    max_val = max_val.max(nums[l]);
                }
                if nums[i] == k && nums[j] == k && max_val == k {
                    ans += 1;
                }
            }
        }
        ans
    }
}
impl Solution {
    pub fn max_subarrays_after_removal(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut ans = 0;
        for i in 0..n {
            for j in i + 1..n {
                let mut temp_nums = nums.clone();
                let mut removed = false;
                let mut cur_or = 0;
                let mut count = 0;
                for k in 0..n {
                    if k == i && !removed{
                        removed = true;
                        continue;
                    }
                    if k == j && !removed {
                        removed = true;
                        continue;
                    }
                    if k == j && removed && i > j{
                        continue;
                    }

                    if k == i && removed && i > j{
                         continue;
                    }

                    cur_or |= temp_nums[k];
                    if cur_or == 0 {
                        count += 1;
                        cur_or = 0;
                    }
                }

                if cur_or != 0 {

                } else {

                }
                ans = ans.max(count);
            }
        }
        let mut cur_or = 0;
        let mut count = 0;
        for k in 0..n {
            cur_or |= nums[k];
            if cur_or == 0 {
                count += 1;
                cur_or = 0;
            }
        }
        ans = ans.max(count);

        ans
    }
}
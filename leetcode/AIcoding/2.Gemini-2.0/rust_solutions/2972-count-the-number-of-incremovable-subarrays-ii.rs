impl Solution {
    pub fn count_the_number_of_incremovable_subarrays(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut count = 0;
        for i in 0..n {
            for j in i..n {
                let mut temp_nums = Vec::new();
                for k in 0..n {
                    if k < i || k > j {
                        temp_nums.push(nums[k]);
                    }
                }

                if temp_nums.is_empty() {
                    count += 1;
                    continue;
                }

                let mut is_increasing = true;
                for k in 0..temp_nums.len() - 1 {
                    if temp_nums[k] >= temp_nums[k + 1] {
                        is_increasing = false;
                        break;
                    }
                }

                if is_increasing {
                    count += 1;
                }
            }
        }
        count
    }
}
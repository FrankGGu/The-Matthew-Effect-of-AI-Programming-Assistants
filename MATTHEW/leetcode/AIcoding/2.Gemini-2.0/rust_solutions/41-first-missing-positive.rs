impl Solution {
    pub fn first_missing_positive(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();

        for i in 0..n {
            if nums[i] <= 0 {
                nums[i] = n as i32 + 1;
            }
        }

        for i in 0..n {
            let num = nums[i].abs() as usize;
            if num <= n {
                let idx = num - 1;
                if nums[idx] > 0 {
                    nums[idx] = -nums[idx];
                }
            }
        }

        for i in 0..n {
            if nums[i] > 0 {
                return (i + 1) as i32;
            }
        }

        (n + 1) as i32
    }
}
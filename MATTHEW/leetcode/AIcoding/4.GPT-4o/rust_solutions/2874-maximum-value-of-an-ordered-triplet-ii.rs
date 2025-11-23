impl Solution {
    pub fn maximum_value(nums: Vec<Vec<i32>>) -> i32 {
        let n = nums.len();
        let mut max_value = 0;

        for i in 0..n {
            for j in 0..2 {
                let mut temp = nums[i][j];
                if i > 0 {
                    if j == 0 {
                        temp += nums[i - 1][1];
                    } else {
                        temp += nums[i - 1][0];
                    }
                }
                max_value = max_value.max(temp);
            }
        }

        max_value
    }
}
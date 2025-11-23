impl Solution {
    pub fn apply_operations(mut nums: Vec<i32>) -> Vec<i32> {
        for i in 0..nums.len() - 1 {
            if nums[i] == nums[i + 1] {
                nums[i] *= 2;
                nums[i + 1] = 0;
            }
        }

        let mut result = Vec::new();
        let mut zeros = 0;

        for num in nums {
            if num != 0 {
                result.push(num);
            } else {
                zeros += 1;
            }
        }

        for _ in 0..zeros {
            result.push(0);
        }

        result
    }
}
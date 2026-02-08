impl Solution {
    pub fn pivot_array(nums: Vec<i32>, pivot: i32) -> Vec<i32> {
        let mut result: Vec<i32> = Vec::with_capacity(nums.len());

        for &num in &nums {
            if num < pivot {
                result.push(num);
            }
        }

        for &num in &nums {
            if num == pivot {
                result.push(num);
            }
        }

        for &num in &nums {
            if num > pivot {
                result.push(num);
            }
        }

        result
    }
}
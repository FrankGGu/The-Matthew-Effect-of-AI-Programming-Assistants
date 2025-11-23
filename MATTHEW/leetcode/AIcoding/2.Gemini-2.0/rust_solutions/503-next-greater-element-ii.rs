impl Solution {
    pub fn next_greater_elements(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![-1; n];
        let mut stack: Vec<usize> = Vec::new();

        for i in 0..2 * n {
            let num = nums[i % n];
            while !stack.is_empty() && num > nums[*stack.last().unwrap()] {
                let index = stack.pop().unwrap();
                result[index] = num;
            }
            if i < n {
                stack.push(i);
            }
        }

        result
    }
}
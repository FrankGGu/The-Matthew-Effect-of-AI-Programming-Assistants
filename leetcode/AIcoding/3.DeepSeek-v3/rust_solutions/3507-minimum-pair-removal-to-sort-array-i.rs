impl Solution {
    pub fn min_pair_removal(nums: Vec<i32>) -> i32 {
        let mut stack = Vec::new();
        let mut count = 0;

        for num in nums {
            while !stack.is_empty() && stack.last().unwrap() > &num {
                stack.pop();
                count += 1;
            }
            stack.push(num);
        }

        count
    }
}
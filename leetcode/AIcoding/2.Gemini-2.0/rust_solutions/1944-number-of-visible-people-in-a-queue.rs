impl Solution {
    pub fn can_see_persons_count(heights: Vec<i32>) -> Vec<i32> {
        let n = heights.len();
        let mut result = vec![0; n];
        let mut stack: Vec<i32> = Vec::new();

        for i in (0..n).rev() {
            let mut count = 0;
            while !stack.is_empty() && heights[i] > *stack.last().unwrap() {
                stack.pop();
                count += 1;
            }
            if !stack.is_empty() {
                count += 1;
            }
            result[i] = count;
            stack.push(heights[i]);
        }

        result
    }
}
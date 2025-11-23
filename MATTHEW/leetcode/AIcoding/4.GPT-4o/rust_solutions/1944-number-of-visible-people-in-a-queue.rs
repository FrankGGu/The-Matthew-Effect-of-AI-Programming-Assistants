impl Solution {
    pub fn can_see_people(heights: Vec<i32>) -> Vec<i32> {
        let n = heights.len();
        let mut result = vec![0; n];
        let mut stack = Vec::new();

        for i in 0..n {
            while let Some(&j) = stack.last() {
                if heights[j] <= heights[i] {
                    stack.pop();
                    result[j] += 1;
                } else {
                    break;
                }
            }
            stack.push(i);
        }

        stack.clear();

        for i in (0..n).rev() {
            while let Some(&j) = stack.last() {
                if heights[j] < heights[i] {
                    stack.pop();
                    result[j] += 1;
                } else {
                    break;
                }
            }
            stack.push(i);
        }

        result
    }
}
impl Solution {
    pub fn can_see_persons(heights: Vec<i32>) -> Vec<i32> {
        let mut stack = Vec::new();
        let mut res = vec![0; heights.len()];

        for i in (0..heights.len()).rev() {
            let mut count = 0;
            while let Some(&top) = stack.last() {
                count += 1;
                if top <= heights[i] {
                    stack.pop();
                } else {
                    break;
                }
            }
            res[i] = count;
            stack.push(heights[i]);
        }
        res
    }
}
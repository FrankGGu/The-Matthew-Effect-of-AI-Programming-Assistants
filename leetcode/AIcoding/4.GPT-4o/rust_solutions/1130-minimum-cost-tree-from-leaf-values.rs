impl Solution {
    pub fn mct_from_leaf_values(arr: Vec<i32>) -> i32 {
        use std::collections::VecDeque;
        let mut stack = VecDeque::new();
        let mut result = 0;
        let mut last = i32::MAX;

        for &value in arr.iter() {
            while let Some(&top) = stack.back() {
                if top <= value {
                    break;
                }
                result += top * last;
                last = top;
                stack.pop_back();
            }
            stack.push_back(value);
        }

        while let Some(top) = stack.pop_back() {
            result += top * last;
            last = top;
        }

        result
    }
}
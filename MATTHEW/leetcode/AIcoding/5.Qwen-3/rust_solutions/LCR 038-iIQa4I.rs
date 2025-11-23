struct Solution;

impl Solution {
    pub fn daily_temperatures(temperatures: Vec<i32>) -> Vec<i32> {
        let n = temperatures.len();
        let mut result = vec![-1; n];
        let mut stack = Vec::new();

        for i in 0..n {
            while let Some(&j) = stack.last() {
                if temperatures[j] < temperatures[i] {
                    result[j] = (i - j) as i32;
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(i);
        }

        result
    }
}
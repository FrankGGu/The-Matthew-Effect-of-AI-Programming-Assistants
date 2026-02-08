impl Solution {
    pub fn daily_temperatures(temperatures: Vec<i32>) -> Vec<i32> {
        let n = temperatures.len();
        let mut result = vec![0; n];
        let mut stack: Vec<usize> = Vec::new();

        for i in 0..n {
            while let Some(&top) = stack.last() {
                if temperatures[i] > temperatures[top] {
                    result[top] = (i - top) as i32;
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
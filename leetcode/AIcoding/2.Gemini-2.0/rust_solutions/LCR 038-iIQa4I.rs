impl Solution {
    pub fn daily_temperatures(temperatures: Vec<i32>) -> Vec<i32> {
        let n = temperatures.len();
        let mut result = vec![0; n];
        let mut stack: Vec<usize> = Vec::new();

        for i in 0..n {
            while !stack.is_empty() && temperatures[*stack.last().unwrap()] < temperatures[i] {
                let prev_index = stack.pop().unwrap();
                result[prev_index] = (i - prev_index) as i32;
            }
            stack.push(i);
        }

        result
    }
}
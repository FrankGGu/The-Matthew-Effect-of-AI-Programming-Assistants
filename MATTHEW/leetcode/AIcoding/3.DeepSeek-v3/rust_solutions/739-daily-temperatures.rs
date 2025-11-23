impl Solution {
    pub fn daily_temperatures(temperatures: Vec<i32>) -> Vec<i32> {
        let mut stack: Vec<usize> = Vec::new();
        let mut result = vec![0; temperatures.len()];

        for i in 0..temperatures.len() {
            while let Some(&last) = stack.last() {
                if temperatures[i] > temperatures[last] {
                    result[last] = (i - last) as i32;
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
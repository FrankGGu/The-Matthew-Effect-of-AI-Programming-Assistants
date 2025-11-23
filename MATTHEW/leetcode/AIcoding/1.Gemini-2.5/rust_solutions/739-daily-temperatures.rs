impl Solution {
    pub fn daily_temperatures(temperatures: Vec<i32>) -> Vec<i32> {
        let n = temperatures.len();
        let mut answer = vec![0; n];
        let mut stack: Vec<usize> = Vec::new();

        for i in 0..n {
            let current_temp = temperatures[i];
            while let Some(&prev_idx) = stack.last() {
                if temperatures[prev_idx] < current_temp {
                    stack.pop();
                    answer[prev_idx] = (i - prev_idx) as i32;
                } else {
                    break;
                }
            }
            stack.push(i);
        }

        answer
    }
}
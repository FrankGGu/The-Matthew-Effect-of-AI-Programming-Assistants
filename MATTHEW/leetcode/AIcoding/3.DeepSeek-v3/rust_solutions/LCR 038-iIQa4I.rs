impl Solution {
    pub fn daily_temperatures(temperatures: Vec<i32>) -> Vec<i32> {
        let mut res = vec![0; temperatures.len()];
        let mut stack = Vec::new();

        for i in 0..temperatures.len() {
            while let Some(&last) = stack.last() {
                if temperatures[i] > temperatures[last] {
                    res[last] = (i - last) as i32;
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(i);
        }

        res
    }
}
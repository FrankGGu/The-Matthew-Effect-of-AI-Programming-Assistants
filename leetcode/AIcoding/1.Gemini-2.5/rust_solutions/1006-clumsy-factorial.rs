struct Solution;

impl Solution {
    pub fn clumsy(n: i32) -> i32 {
        let mut stack: Vec<i32> = Vec::new();
        stack.push(n);

        let mut num_idx = 1;
        let mut current_val = n - 1;

        while current_val > 0 {
            let op_type = (num_idx - 1) % 4;

            match op_type {
                0 => {
                    let top = stack.pop().unwrap();
                    stack.push(top * current_val);
                },
                1 => {
                    let top = stack.pop().unwrap();
                    stack.push(top / current_val);
                },
                2 => {
                    stack.push(current_val);
                },
                3 => {
                    stack.push(-current_val);
                },
                _ => unreachable!(),
            }

            num_idx += 1;
            current_val -= 1;
        }

        stack.iter().sum()
    }
}
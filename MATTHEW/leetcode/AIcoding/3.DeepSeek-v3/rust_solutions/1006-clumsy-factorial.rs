impl Solution {
    pub fn clumsy(n: i32) -> i32 {
        let mut stack = vec![n];
        let mut index = n - 1;
        let mut op = 0;

        while index > 0 {
            match op % 4 {
                0 => {
                    let top = stack.pop().unwrap();
                    stack.push(top * index);
                },
                1 => {
                    let top = stack.pop().unwrap();
                    stack.push(top / index);
                },
                2 => {
                    stack.push(index);
                },
                3 => {
                    stack.push(-index);
                },
                _ => unreachable!(),
            }
            op += 1;
            index -= 1;
        }

        stack.iter().sum()
    }
}
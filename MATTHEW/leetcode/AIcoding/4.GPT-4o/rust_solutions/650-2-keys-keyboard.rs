impl Solution {
    pub fn min_steps(n: i32) -> i32 {
        let mut steps = 0;
        let mut num = n;
        let mut factor = 2;

        while num > 1 {
            while num % factor == 0 {
                steps += factor;
                num /= factor;
            }
            factor += 1;
        }

        steps
    }
}
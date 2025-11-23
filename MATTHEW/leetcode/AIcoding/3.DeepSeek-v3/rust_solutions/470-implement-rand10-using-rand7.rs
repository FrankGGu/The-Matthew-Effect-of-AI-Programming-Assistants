impl Solution {
    pub fn rand10() -> i32 {
        loop {
            let num = (rand7() - 1) * 7 + rand7();
            if num <= 40 {
                return num % 10 + 1;
            }
        }
    }
}
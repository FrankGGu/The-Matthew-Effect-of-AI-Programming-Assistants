impl Solution {
    pub fn integer_break(n: i32) -> i32 {
        if n <= 3 {
            return n - 1;
        }
        let mut product = 1;
        let mut num = n;
        while num > 4 {
            product *= 3;
            num -= 3;
        }
        product * num
    }
}
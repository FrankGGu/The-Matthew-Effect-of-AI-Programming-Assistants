impl Solution {
    pub fn eat_pizzas(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        if n % 3 == 0 {
            return n / 3;
        } else if n % 3 == 1 {
            if n >= 7 {
                return (n - 7) / 3 + 3;
            } else {
                return -1;
            }
        } else {
            return (n - 2) / 3 + 1;
        }
    }
}
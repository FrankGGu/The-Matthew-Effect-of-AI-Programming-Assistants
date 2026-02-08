impl Solution {
    pub fn make_the_integer_zero(num1: i32, num2: i32) -> i32 {
        if num1 < num2 {
            return -1;
        }
        if num1 == num2 {
            return -1;
        }
        if num2 >= 0 {
            return -1;
        }

        for k in 1..=60 {
            let n = num1 - (num2 * k);
            if n <= 0 {
                continue;
            }
            let bits = n.count_ones();
            if bits as i32 <= k && k <= n {
                return k;
            }
        }

        return -1;
    }
}
impl Solution {
    pub fn reverse(x: i32) -> i32 {
        let mut reversed: i32 = 0;
        let mut num = x;

        while num != 0 {
            let digit = num % 10;
            num /= 10;

            match reversed.checked_mul(10).and_then(|res| res.checked_add(digit)) {
                Some(new_reversed) => reversed = new_reversed,
                None => return 0,
            }
        }

        reversed
    }
}
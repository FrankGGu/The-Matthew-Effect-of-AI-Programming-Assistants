impl Solution {
    pub fn next_greater_numerically_balanced_number(n: i32) -> i32 {
        let mut i = n + 1;
        loop {
            if Self::is_balanced(i) {
                return i;
            }
            i += 1;
        }
    }

    fn is_balanced(mut n: i32) -> bool {
        let mut counts = [0; 10];
        let mut temp_n = n;
        while temp_n > 0 {
            let digit = temp_n % 10;
            counts[digit as usize] += 1;
            temp_n /= 10;
        }

        for d in 0..10 {
            if counts[d] > 0 {
                if counts[d] != d as i32 {
                    return false;
                }
            }
        }
        true
    }
}
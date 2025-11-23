impl Solution {
    pub fn last_remaining(n: i32) -> i32 {
        let mut head = 1;
        let mut remaining = n;
        let mut step = 1;
        let mut left_to_right = true;

        while remaining > 1 {
            if left_to_right {
                head += step;
            } else {
                if remaining % 2 == 1 {
                    head += step;
                }
            }

            remaining /= 2;
            step *= 2;
            left_to_right = !left_to_right;
        }

        head
    }
}
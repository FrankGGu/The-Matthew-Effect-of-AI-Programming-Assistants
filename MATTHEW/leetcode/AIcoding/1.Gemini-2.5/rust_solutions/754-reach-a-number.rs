impl Solution {
    pub fn reach_number(target: i32) -> i32 {
        let mut target = target.abs();
        let mut n = 0;
        let mut sum = 0;

        loop {
            n += 1;
            sum += n;

            if sum >= target && (sum - target) % 2 == 0 {
                return n;
            }
        }
    }
}
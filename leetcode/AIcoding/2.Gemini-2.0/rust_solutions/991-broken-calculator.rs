impl Solution {
    pub fn broken_calc(start_value: i32, target: i32) -> i32 {
        let mut res = 0;
        let mut curr = target;

        while curr > start_value {
            if curr % 2 == 0 {
                curr /= 2;
            } else {
                curr += 1;
            }
            res += 1;
        }

        res + start_value - curr
    }
}
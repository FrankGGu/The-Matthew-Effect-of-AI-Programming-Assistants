impl Solution {
    pub fn reach_number(target: i32) -> i32 {
        let target = target.abs();
        let mut k = 0;
        let mut sum = 0;
        while sum < target {
            k += 1;
            sum += k;
        }
        let diff = sum - target;
        if diff % 2 == 0 {
            k
        } else {
            if k % 2 == 1 {
                k + 2
            } else {
                k + 1
            }
        }
    }
}
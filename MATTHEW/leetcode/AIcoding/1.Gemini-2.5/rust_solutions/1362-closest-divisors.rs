impl Solution {
    fn find_closest_divisors_for_target(target: i32) -> (i32, i32) {
        let sqrt_target = (target as f64).sqrt() as i32;
        for i in (1..=sqrt_target).rev() {
            if target % i == 0 {
                return (i, target / i);
            }
        }
        // This case should ideally not be reached for target >= 1,
        // as 1 is always a divisor.
        (1, target)
    }

    pub fn closest_divisors(num: i32) -> Vec<i32> {
        let target1 = num + 1;
        let target2 = num + 2;

        let (a1, b1) = Self::find_closest_divisors_for_target(target1);
        let (a2, b2) = Self::find_closest_divisors_for_target(target2);

        if (a1 - b1).abs() <= (a2 - b2).abs() {
            vec![a1, b1]
        } else {
            vec![a2, b2]
        }
    }
}
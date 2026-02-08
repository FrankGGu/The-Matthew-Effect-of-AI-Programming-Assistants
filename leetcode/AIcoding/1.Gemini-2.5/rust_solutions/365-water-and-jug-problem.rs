impl Solution {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn can_measure_water(jug1_capacity: i32, jug2_capacity: i32, target_capacity: i32) -> bool {
        if target_capacity == 0 {
            return true;
        }
        if jug1_capacity + jug2_capacity < target_capacity {
            return false;
        }

        let common_divisor = Self::gcd(jug1_capacity, jug2_capacity);
        target_capacity % common_divisor == 0
    }
}
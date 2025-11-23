impl Solution {
    pub fn can_measure_water(jug1_capacity: i32, jug2_capacity: i32, target_capacity: i32) -> bool {
        if target_capacity > jug1_capacity + jug2_capacity {
            return false;
        }
        if target_capacity == 0 || target_capacity == jug1_capacity || target_capacity == jug2_capacity {
            return true;
        }
        let gcd = |a: i32, b: i32| {
            let mut a = a;
            let mut b = b;
            while b != 0 {
                let temp = b;
                b = a % b;
                a = temp;
            }
            a
        };
        target_capacity % gcd(jug1_capacity, jug2_capacity) == 0
    }
}
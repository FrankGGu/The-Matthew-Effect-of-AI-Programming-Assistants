impl Solution {
    pub fn can_measure_water(jug1_capacity: i32, jug2_capacity: i32, target_capacity: i32) -> bool {
        if target_capacity > jug1_capacity + jug2_capacity {
            return false;
        }
        if target_capacity == 0 {
            return true;
        }

        if jug1_capacity == 0 && jug2_capacity == 0 {
            return target_capacity == 0;
        }

        if jug1_capacity == 0 {
            return target_capacity == jug2_capacity;
        }

        if jug2_capacity == 0 {
            return target_capacity == jug1_capacity;
        }

        fn gcd(a: i32, b: i32) -> i32 {
            if b == 0 {
                a
            } else {
                gcd(b, a % b)
            }
        }

        let g = gcd(jug1_capacity, jug2_capacity);
        target_capacity % g == 0
    }
}
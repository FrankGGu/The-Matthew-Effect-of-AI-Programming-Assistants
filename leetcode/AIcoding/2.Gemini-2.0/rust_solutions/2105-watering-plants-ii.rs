impl Solution {
    pub fn watering_plants(plants: Vec<i32>, capacity_a: i32, capacity_b: i32) -> i32 {
        let n = plants.len();
        let mut a_cap = capacity_a;
        let mut b_cap = capacity_b;
        let mut steps = 0;
        let mut a_idx = 0;
        let mut b_idx = n - 1;

        while a_idx < b_idx {
            if a_cap >= plants[a_idx] {
                a_cap -= plants[a_idx];
            } else {
                steps += 1;
                a_cap = capacity_a - plants[a_idx];
            }
            a_idx += 1;

            if b_cap >= plants[b_idx] {
                b_cap -= plants[b_idx];
            } else {
                steps += 1;
                b_cap = capacity_b - plants[b_idx];
            }
            b_idx -= 1;
        }

        if a_idx == b_idx {
            if a_cap >= b_cap {
                if a_cap >= plants[a_idx] {

                } else {
                    steps += 1;
                }
            } else {
                if b_cap >= plants[a_idx] {

                } else {
                    steps += 1;
                }
            }
        }

        if a_idx == b_idx && a_cap + b_cap < plants[a_idx] {
            steps += 1;
        }

        steps
    }
}
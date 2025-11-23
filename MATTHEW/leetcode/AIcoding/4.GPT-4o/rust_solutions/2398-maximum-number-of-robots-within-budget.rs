impl Solution {
    pub fn maximum_robots(charges: Vec<i32>, budget: i32) -> i32 {
        let n = charges.len();
        let mut max_robots = 0;
        let mut left = 0;
        let mut total_cost = 0;
        let mut max_charge = 0;

        for right in 0..n {
            total_cost += charges[right];
            max_charge = max_charge.max(charges[right]);

            while total_cost + (max_charge * (right - left + 1)) > budget {
                total_cost -= charges[left];
                left += 1;
                max_charge = *charges[left..=right].iter().max().unwrap_or(&0);
            }

            max_robots = max_robots.max((right - left + 1) as i32);
        }

        max_robots
    }
}
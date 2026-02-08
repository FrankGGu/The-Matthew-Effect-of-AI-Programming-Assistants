impl Solution {
    pub fn minimum_refill(plants: Vec<i32>, capacity_a: i32, capacity_b: i32) -> i32 {
        let mut left = 0;
        let mut right = plants.len() - 1;
        let mut a = capacity_a;
        let mut b = capacity_b;
        let mut res = 0;

        while left <= right {
            if left == right {
                if a >= b {
                    if a < plants[left] {
                        res += 1;
                    }
                } else {
                    if b < plants[right] {
                        res += 1;
                    }
                }
                break;
            }

            if a < plants[left] {
                a = capacity_a;
                res += 1;
            }
            a -= plants[left];
            left += 1;

            if b < plants[right] {
                b = capacity_b;
                res += 1;
            }
            b -= plants[right];
            right -= 1;
        }

        res
    }
}
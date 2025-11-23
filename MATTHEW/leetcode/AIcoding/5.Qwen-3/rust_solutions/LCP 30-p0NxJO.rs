struct Solution;

impl Solution {
    pub fn magic_tower(mut arr: Vec<i32>) -> i32 {
        let mut total = 1;
        for num in &arr {
            total *= *num;
        }
        if total < 0 {
            return -1;
        }
        let mut res = 0;
        let mut health = 1;
        let mut min_health = 1;
        for num in arr {
            health *= num;
            if health < min_health {
                min_health = health;
                res += 1;
            }
        }
        res
    }
}
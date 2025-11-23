pub fn magic_tower(nums: Vec<i32>) -> bool {
    let mut health = 1;
    let mut total_health = 0;

    for &num in &nums {
        health += num;
        if health <= 0 {
            return false;
        }
        total_health += health;
    }

    health = 1;
    for &num in nums.iter().rev() {
        health += num;
        if health <= 0 {
            return false;
        }
        total_health += health;
    }

    total_health >= 0
}
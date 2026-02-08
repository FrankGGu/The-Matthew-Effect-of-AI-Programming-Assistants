impl Solution {
    pub fn can_destroy(mass: i332, mut asteroids: Vec<i32>) -> bool {
        let mut current_mass: i64 = mass as i64;
        asteroids.sort_unstable();

        for asteroid_mass in asteroids {
            if current_mass < asteroid_mass as i64 {
                return false;
            }
            current_mass += asteroid_mass as i64;
        }
        true
    }
}
impl Solution {
    pub fn asteroids_destroying(mut mass: i32, mut asteroids: Vec<i32>) -> bool {
        asteroids.sort();
        for &asteroid in &asteroids {
            if mass < asteroid {
                return false;
            }
            mass += asteroid;
        }
        true
    }
}
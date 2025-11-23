impl Solution {
    pub fn asteroids_destroyed(mass: i32, asteroids: Vec<i32>) -> bool {
        let mut mass = mass as i64;
        let mut asteroids = asteroids;
        asteroids.sort();
        for &asteroid in asteroids.iter() {
            let asteroid = asteroid as i64;
            if mass < asteroid {
                return false;
            }
            mass += asteroid;
        }
        true
    }
}
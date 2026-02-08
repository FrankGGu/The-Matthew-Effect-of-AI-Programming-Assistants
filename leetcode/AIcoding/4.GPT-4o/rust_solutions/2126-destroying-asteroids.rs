impl Solution {
    pub fn asteroids_destroyed(mass: i32, asteroids: Vec<i32>) -> bool {
        let mut mass = mass;
        let mut asteroids = asteroids;
        asteroids.sort();

        for asteroid in asteroids {
            if mass >= asteroid {
                mass += asteroid;
            } else {
                return false;
            }
        }
        true
    }
}
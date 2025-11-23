struct Solution;

impl Solution {
    pub fn destroy_asteroids(mut asteroids: Vec<i32>) -> bool {
        asteroids.sort();
        let mut ship_size = 1;
        for asteroid in asteroids {
            if ship_size >= asteroid {
                ship_size += asteroid;
            } else {
                return false;
            }
        }
        true
    }
}
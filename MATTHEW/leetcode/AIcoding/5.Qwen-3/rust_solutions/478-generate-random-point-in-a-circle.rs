impl Solution {

use std::f64::consts::PI;
use std::collections::HashSet;

struct Solution {
    radius: f64,
    x_center: f64,
    y_center: f64,
}

impl Solution {
    fn new(radius: f64, x_center: f64, y_center: f64) -> Self {
        Solution {
            radius,
            x_center,
            y_center,
        }
    }

    fn rand_point(&self) -> Vec<f64> {
        let mut rng = rand::thread_rng();
        let mut r = 0.0;
        let mut theta = 0.0;
        while r == 0.0 {
            r = rng.gen_range(0.0..=1.0);
            theta = rng.gen_range(0.0..2.0 * PI);
        }
        let x = self.x_center + r * self.radius * theta.cos();
        let y = self.y_center + r * self.radius * theta.sin();
        vec![x, y]
    }
}
}
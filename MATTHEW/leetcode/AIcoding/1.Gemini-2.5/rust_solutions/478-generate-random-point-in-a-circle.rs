use rand::Rng;
use std::f64::consts::PI;

struct Solution {
    radius: f64,
    x_center: f64,
    y_center: f64,
    rng: rand::rngs::ThreadRng,
}

impl Solution {
    fn new(radius: f64, x_center: f64, y_center: f64) -> Self {
        Solution {
            radius,
            x_center,
            y_center,
            rng: rand::thread_rng(),
        }
    }

    fn rand_point(&mut self) -> Vec<f64> {
        let r_scaled = self.rng.gen_range(0.0..1.0f64).sqrt();
        let r = self.radius * r_scaled;
        let theta = 2.0 * PI * self.rng.gen_range(0.0..1.0f64);

        let x = self.x_center + r * theta.cos();
        let y = self.y_center + r * theta.sin();

        vec![x, y]
    }
}
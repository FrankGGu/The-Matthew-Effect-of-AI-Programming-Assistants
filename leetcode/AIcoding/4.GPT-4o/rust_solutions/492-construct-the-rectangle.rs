impl Solution {
    pub fn construct_rectangle(area: i32) -> Vec<i32> {
        let width = (area as f64).sqrt().floor() as i32;
        for w in (1..=width).rev() {
            if area % w == 0 {
                return vec![area / w, w];
            }
        }
        vec![]
    }
}
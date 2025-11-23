impl Solution {
    pub fn highest_elevation(elevations: Vec<i32>) -> i32 {
        *elevations.iter().max().unwrap()
    }
}
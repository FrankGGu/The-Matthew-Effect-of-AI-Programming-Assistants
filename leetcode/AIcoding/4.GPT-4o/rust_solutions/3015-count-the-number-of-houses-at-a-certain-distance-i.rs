impl Solution {
    pub fn count_houses(distance: i32, houses: Vec<i32>) -> i32 {
        let mut count = 0;
        for &house in &houses {
            if houses.iter().any(|&h| (h - house).abs() == distance) {
                count += 1;
            }
        }
        count
    }
}
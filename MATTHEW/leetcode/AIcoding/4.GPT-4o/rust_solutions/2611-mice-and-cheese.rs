impl Solution {
    pub fn mice_and_cheese(mouse: Vec<i32>, cheese: Vec<i32>, k: usize) -> i32 {
        let mut differences: Vec<i32> = mouse.iter().zip(cheese.iter()).map(|(m, c)| m - c).collect();
        differences.sort_unstable();
        let total: i32 = mouse.iter().sum();
        let skipped: i32 = differences.iter().take(k).sum();
        total - skipped
    }
}
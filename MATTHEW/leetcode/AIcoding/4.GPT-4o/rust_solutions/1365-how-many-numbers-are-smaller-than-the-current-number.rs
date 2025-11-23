impl Solution {
    pub fn smaller_numbers_than_current(nums: Vec<i32>) -> Vec<i32> {
        let mut counts = vec![0; 101];
        for &num in &nums {
            counts[num as usize] += 1;
        }

        for i in 1..counts.len() {
            counts[i] += counts[i - 1];
        }

        nums.into_iter().map(|num| {
            if num > 0 {
                counts[num as usize - 1]
            } else {
                0
            }
        }).collect()
    }
}
impl Solution {
    pub fn smaller_numbers_than_current(nums: Vec<i32>) -> Vec<i32> {
        let mut freq = vec![0; 101];
        for &num in &nums {
            freq[num as usize] += 1;
        }

        let mut smaller_counts = vec![0; 101];
        for i in 1..101 {
            smaller_counts[i] = smaller_counts[i - 1] + freq[i - 1];
        }

        let mut result = Vec::with_capacity(nums.len());
        for &num in &nums {
            result.push(smaller_counts[num as usize]);
        }
        result
    }
}
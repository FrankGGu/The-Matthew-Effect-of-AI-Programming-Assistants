impl Solution {
    pub fn num_identical_pairs(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut freq = vec![0; 101];

        for &num in &nums {
            count += freq[num as usize];
            freq[num as usize] += 1;
        }

        count
    }
}
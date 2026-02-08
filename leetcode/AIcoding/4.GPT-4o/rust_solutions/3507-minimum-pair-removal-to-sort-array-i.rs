impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut freq = vec![0; 101];

        for &num in &nums {
            freq[num as usize] += 1;
        }

        for &f in &freq {
            if f > 1 {
                count += f / 2;
            }
        }

        count
    }
}
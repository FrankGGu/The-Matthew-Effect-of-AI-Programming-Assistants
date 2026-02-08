impl Solution {
    pub fn find_matrix(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let n = nums.len();

        let mut freq = vec![0; n + 1];
        let mut max_freq = 0;

        for &num in &nums {
            freq[num as usize] += 1;
            if freq[num as usize] > max_freq {
                max_freq = freq[num as usize];
            }
        }

        let mut result: Vec<Vec<i32>> = vec![Vec::new(); max_freq];

        let mut current_row_indices = vec![0; n + 1];

        for &num in &nums {
            let row_idx = current_row_indices[num as usize];
            result[row_idx].push(num);
            current_row_indices[num as usize] += 1;
        }

        result
    }
}
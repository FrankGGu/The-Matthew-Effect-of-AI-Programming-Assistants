impl Solution {
    pub fn max_frequency_elements(nums: Vec<i32>) -> i32 {
        let mut frequencies = vec![0; 101];

        for &num in &nums {
            frequencies[num as usize] += 1;
        }

        let mut max_freq = 0;
        for &freq in &frequencies {
            if freq > max_freq {
                max_freq = freq;
            }
        }

        let mut count_max_freq_elements = 0;
        for &freq in &frequencies {
            if freq == max_freq {
                count_max_freq_elements += 1;
            }
        }

        count_max_freq_elements * max_freq
    }
}
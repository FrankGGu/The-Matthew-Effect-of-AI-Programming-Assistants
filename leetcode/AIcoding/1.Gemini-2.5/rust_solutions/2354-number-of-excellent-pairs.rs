use std::collections::HashSet;

impl Solution {
    pub fn count_excellent_pairs(nums: Vec<i32>, k: i32) -> i64 {
        let mut unique_nums = HashSet::new();
        for num in nums {
            unique_nums.insert(num);
        }

        let mut freq_array = vec![0; 31]; 
        for &num in unique_nums.iter() {
            let set_bits = num.count_ones() as usize;
            freq_array[set_bits] += 1;
        }

        let mut excellent_pairs_count: i64 = 0;

        for count1 in 0..=30 {
            for count2 in 0..=30 {
                if count1 + count2 >= k {
                    excellent_pairs_count += (freq_array[count1 as usize] as i64) * (freq_array[count2 as usize] as i64);
                }
            }
        }

        excellent_pairs_count
    }
}
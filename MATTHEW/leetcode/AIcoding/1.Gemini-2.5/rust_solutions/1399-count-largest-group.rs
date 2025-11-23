impl Solution {
    pub fn count_largest_group(n: i32) -> i32 {
        let mut group_sizes_counts = vec![0; 37]; // Maximum possible digit sum for n=9999 is 36. For n=10000, it's 1.

        for i in 1..=n {
            let mut num = i;
            let mut digit_sum = 0;
            while num > 0 {
                digit_sum += num % 10;
                num /= 10;
            }
            group_sizes_counts[digit_sum as usize] += 1;
        }

        let mut max_group_size = 0;
        for &count in &group_sizes_counts {
            if count > max_group_size {
                max_group_size = count;
            }
        }

        let mut num_largest_groups = 0;
        for &count in &group_sizes_counts {
            if count == max_group_size {
                num_largest_groups += 1;
            }
        }

        num_largest_groups
    }
}
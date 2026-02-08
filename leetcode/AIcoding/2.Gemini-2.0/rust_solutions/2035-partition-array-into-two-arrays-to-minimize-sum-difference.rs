impl Solution {
    pub fn minimum_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let half = n / 2;
        let total_sum: i32 = nums.iter().sum();

        let mut left_sums: Vec<Vec<i32>> = vec![Vec::new(); half + 1];
        let mut right_sums: Vec<Vec<i32>> = vec![Vec::new(); half + 1];

        fn generate_sums(nums: &[i32], start: usize, end: usize, count: usize, current_sum: i32, sums: &mut Vec<Vec<i32>>) {
            if start == end {
                sums[count].push(current_sum);
                return;
            }

            generate_sums(nums, start + 1, end, count, current_sum, sums);
            generate_sums(nums, start + 1, end, count + 1, current_sum + nums[start], sums);
        }

        generate_sums(&nums[..half], 0, half, 0, 0, &mut left_sums);
        generate_sums(&nums[half..], 0, n - half, 0, 0, &mut right_sums);

        for i in 0..=half {
            left_sums[i].sort();
        }

        let mut min_diff = i32::MAX;

        for i in 0..=half {
            for &left_sum in &left_sums[i] {
                let right_count = half - i;
                let target = (total_sum - 2 * left_sum) / 2;

                let right_vec = &right_sums[right_count];
                let pos = match right_vec.binary_search(&target) {
                    Ok(p) => p,
                    Err(p) => p,
                };

                if pos < right_vec.len() {
                    min_diff = min_diff.min((total_sum - 2 * (left_sum + right_vec[pos])).abs());
                }

                if pos > 0 {
                    min_diff = min_diff.min((total_sum - 2 * (left_sum + right_vec[pos - 1])).abs());
                }
            }
        }

        min_diff
    }
}
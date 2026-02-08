impl Solution {
    pub fn sort_jumbled(mapping: Vec<i32>, nums: Vec<i32>) -> Vec<i32> {
        let mut mapped_nums: Vec<(i32, usize, i32)> = Vec::with_capacity(nums.len());

        for (i, &num) in nums.iter().enumerate() {
            let jumbled_val = Self::calculate_jumbled(num, &mapping);
            mapped_nums.push((jumbled_val, i, num));
        }

        // Sort the vector of tuples.
        // The comparison logic ensures sorting by jumbled_val first,
        // and then by original index (i) for tie-breaking, maintaining stability.
        mapped_nums.sort_unstable_by(|a, b| {
            if a.0 != b.0 {
                a.0.cmp(&b.0)
            } else {
                a.1.cmp(&b.1)
            }
        });

        let mut result: Vec<i32> = Vec::with_capacity(nums.len());
        for (_, _, original_num) in mapped_nums {
            result.push(original_num);
        }

        result
    }

    fn calculate_jumbled(num: i32, mapping: &[i32]) -> i32 {
        if num == 0 {
            return mapping[0];
        }

        let mut original_num = num;
        let mut jumbled_val = 0;
        let mut power_of_10 = 1;

        while original_num > 0 {
            let digit = original_num % 10;
            let mapped_digit = mapping[digit as usize];
            jumbled_val += mapped_digit * power_of_10;

            original_num /= 10;

            // Only multiply power_of_10 if there are more digits to process
            if original_num > 0 {
                power_of_10 *= 10;
            }
        }
        jumbled_val
    }
}
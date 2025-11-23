impl Solution {
    pub fn count_hills_and_valleys(nums: Vec<i32>) -> i32 {
        if nums.len() < 3 {
            return 0;
        }

        let mut count = 0;
        let mut prev_val = nums[0];

        for i in 1..nums.len() - 1 {
            if nums[i] == prev_val {
                continue;
            }

            let mut next_distinct_val_found = false;
            let mut next_distinct_val = 0;

            for k in i + 1..nums.len() {
                if nums[k] != nums[i] {
                    next_distinct_val = nums[k];
                    next_distinct_val_found = true;
                    break;
                }
            }

            if !next_distinct_val_found {
                // If no distinct element is found to the right,
                // nums[i] cannot be a hill or valley, and neither can any subsequent elements.
                break;
            }

            if prev_val < nums[i] && nums[i] > next_distinct_val {
                count += 1;
            } else if prev_val > nums[i] && nums[i] < next_distinct_val {
                count += 1;
            }

            prev_val = nums[i];
        }

        count
    }
}
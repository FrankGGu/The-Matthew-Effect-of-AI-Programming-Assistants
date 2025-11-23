impl Solution {
    pub fn is_straight(mut nums: Vec<i32>) -> bool {
        nums.sort_unstable();

        let mut zero_count = 0;
        let mut i = 0;

        // Count zeros
        while i < nums.len() && nums[i] == 0 {
            zero_count += 1;
            i += 1;
        }

        // If all numbers are zeros, it's a straight (e.g., [0,0,0,0,0] can be 1,2,3,4,5)
        if i == nums.len() {
            return true;
        }

        // 'i' now points to the first non-zero number
        let mut prev_num = nums[i];
        i += 1;

        // Iterate through the rest of the non-zero numbers
        while i < nums.len() {
            let current_num = nums[i];

            // If there's a duplicate non-zero number, it cannot be a straight
            if current_num == prev_num {
                return false;
            }

            // Calculate the gap between the current and previous non-zero number
            // A gap of 0 means they are consecutive (e.g., 2 and 3)
            // A gap of 1 means one number is missing (e.g., 2 and 4, needs a 3)
            let gap = current_num - prev_num - 1;

            if gap > 0 {
                // Use zeros to fill the gap
                zero_count -= gap;
                // If not enough zeros, it cannot be a straight
                if zero_count < 0 {
                    return false;
                }
            }

            prev_num = current_num;
            i += 1;
        }

        // If all checks pass, it's a straight
        true
    }
}
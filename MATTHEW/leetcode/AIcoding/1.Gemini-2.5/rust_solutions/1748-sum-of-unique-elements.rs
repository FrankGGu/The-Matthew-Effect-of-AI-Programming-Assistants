impl Solution {
    pub fn sum_of_unique(nums: Vec<i32>) -> i32 {
        let mut counts = [0; 101]; // Constraints usually specify nums[i] up to 100 or 1000. Assuming max 100 for this example.
                                  // If nums[i] can be up to 1000, change to [0; 1001].
                                  // For typical LeetCode problems, 1 <= nums[i] <= 1000 is common.
                                  // Let's use 1001 to be safe for a broader range.

        let mut actual_counts = [0; 1001]; // Assuming 1 <= nums[i] <= 1000

        for &num in &nums {
            actual_counts[num as usize] += 1;
        }

        let mut sum = 0;
        for i in 1..=1000 { // Iterate through possible numbers from 1 to 1000
            if actual_counts[i as usize] == 1 {
                sum += i;
            }
        }
        sum
    }
}
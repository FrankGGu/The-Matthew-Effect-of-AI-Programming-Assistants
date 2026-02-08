impl Solution {
    pub fn get_subarray_beauty(nums: Vec<i32>, k: i32, x: i32) -> Vec<i32> {
        let n = nums.len();
        let k_usize = k as usize;
        let x_usize = x as usize;
        let mut ans = Vec::new();
        let mut freq = vec![0; 101]; // Frequencies for numbers -50 to 50. Index i corresponds to number i - 50.

        // Helper function to find the x-th smallest element
        // Returns 0 if the x-th smallest is non-negative, otherwise returns the element itself.
        let mut find_beauty = |freq_arr: &[i32]| -> i32 {
            let mut count = 0;
            for i in 0..101 {
                count += freq_arr[i];
                if count >= x_usize as i32 {
                    let beauty = i as i32 - 50;
                    return if beauty >= 0 { 0 } else { beauty };
                }
            }
            // This case should ideally not be reached if k >= x and numbers are within range.
            // If it is, it means there aren't enough numbers to find the x-th smallest.
            // Based on problem constraints, k >= x.
            0
        };

        // Initialize the first window
        for i in 0..k_usize {
            freq[(nums[i] + 50) as usize] += 1;
        }
        ans.push(find_beauty(&freq));

        // Slide the window
        for i in k_usize..n {
            // Remove the element leaving the window
            freq[(nums[i - k_usize] + 50) as usize] -= 1;
            // Add the element entering the window
            freq[(nums[i] + 50) as usize] += 1;
            ans.push(find_beauty(&freq));
        }

        ans
    }
}
impl Solution {
    pub fn num_of_subarrays(arr: Vec<i32>, k: i32, threshold: i32) -> i32 {
        let n = arr.len();
        let k_usize = k as usize;
        let target_sum = k * threshold;

        if k_usize > n {
            return 0;
        }

        let mut count = 0;
        let mut current_sum: i32 = 0;

        // Calculate sum of the first window
        for i in 0..k_usize {
            current_sum += arr[i];
        }

        // Check the first window
        if current_sum >= target_sum {
            count += 1;
        }

        // Slide the window
        for i in k_usize..n {
            current_sum -= arr[i - k_usize]; // Remove element leaving the window
            current_sum += arr[i];           // Add element entering the window

            if current_sum >= target_sum {
                count += 1;
            }
        }

        count
    }
}
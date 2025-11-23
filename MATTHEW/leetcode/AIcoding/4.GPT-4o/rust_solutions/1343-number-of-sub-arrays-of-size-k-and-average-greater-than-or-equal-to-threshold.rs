impl Solution {
    pub fn num_of_subarrays(arr: Vec<i32>, k: i32, threshold: i32) -> i32 {
        let n = arr.len();
        let target = k * threshold;
        let mut sum = 0;
        let mut count = 0;

        for i in 0..k as usize {
            sum += arr[i];
        }

        if sum >= target {
            count += 1;
        }

        for i in k as usize..n {
            sum += arr[i] - arr[i - k as usize];
            if sum >= target {
                count += 1;
            }
        }

        count
    }
}
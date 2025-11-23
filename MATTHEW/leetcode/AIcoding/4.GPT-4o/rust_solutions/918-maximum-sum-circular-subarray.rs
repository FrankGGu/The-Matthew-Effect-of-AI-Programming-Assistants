impl Solution {
    pub fn max_subarray_sum_circular(nums: Vec<i32>) -> i32 {
        let total: i32 = nums.iter().sum();
        let max_kadane = |arr: &[i32]| {
            let mut max_ending_here = arr[0];
            let mut max_so_far = arr[0];
            for &num in &arr[1..] {
                max_ending_here = max_ending_here.max(num);
                max_so_far = max_so_far.max(max_ending_here);
            }
            max_so_far
        };

        let max_kadane_sum = max_kadane(&nums);
        let min_kadane_sum = max_kadane(&nums.iter().map(|&x| -x).collect::<Vec<_>>());
        let max_circular_sum = total + min_kadane_sum;

        max_kadane_sum.max(max_circular_sum)
    }
}
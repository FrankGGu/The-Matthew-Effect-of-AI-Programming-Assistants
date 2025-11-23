impl Solution {
    pub fn number_of_subarrays(nums: Vec<i32>, pattern: Vec<i32>) -> i32 {
        fn at_most(nums: &Vec<i32>, pattern: &Vec<i32>) -> i32 {
            let (n, m) = (nums.len(), pattern.len());
            let mut count = 0;
            let mut left = 0;
            let mut freq = vec![0; 1001];

            for right in 0..n {
                freq[nums[right] as usize] += 1;

                while left <= right && !pattern.iter().all(|&x| freq[x as usize] > 0) {
                    freq[nums[left] as usize] -= 1;
                    left += 1;
                }

                count += right - left + 1;
            }
            count
        }

        at_most(&nums, &pattern) - at_most(&nums, &pattern[1..]) - at_most(&nums, &pattern[..pattern.len()-1])
    }
}
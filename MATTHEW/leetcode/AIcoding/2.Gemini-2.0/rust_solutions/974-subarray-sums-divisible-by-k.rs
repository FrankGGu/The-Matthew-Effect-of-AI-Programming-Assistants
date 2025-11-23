impl Solution {
    pub fn subarrays_div_by_k(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut prefix_sums = vec![0; k as usize];
        prefix_sums[0] = 1;
        let mut current_sum = 0;
        for num in nums {
            current_sum = (current_sum + num) % k;
            if current_sum < 0 {
                current_sum += k;
            }
            count += prefix_sums[current_sum as usize];
            prefix_sums[current_sum as usize] += 1;
        }
        count
    }
}
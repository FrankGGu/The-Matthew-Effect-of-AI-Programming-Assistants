pub fn max_sum_two_no_overlap(nums: Vec<i32>, first_len: i32, second_len: i32) -> i32 {
    let n = nums.len();
    let first_len = first_len as usize;
    let second_len = second_len as usize;

    fn get_max_sum(nums: &[i32], first_len: usize, second_len: usize) -> i32 {
        let n = nums.len();
        let mut first_sum = 0;
        let mut second_sum = 0;
        let mut max_first = 0;
        let mut total_max = 0;

        for i in 0..n {
            if i < first_len {
                first_sum += nums[i];
            } else {
                first_sum += nums[i] - nums[i - first_len];
            }
            max_first = max_first.max(first_sum);
            if i >= first_len {
                second_sum += nums[i];
                if i >= first_len + second_len {
                    second_sum -= nums[i - second_len];
                }
                total_max = total_max.max(max_first + second_sum);
            }
        }
        total_max
    }

    get_max_sum(&nums, first_len, second_len).max(get_max_sum(&nums, second_len, first_len))
}
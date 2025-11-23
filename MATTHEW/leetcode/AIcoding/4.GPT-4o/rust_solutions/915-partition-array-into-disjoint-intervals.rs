pub fn partition_disjoint(nums: Vec<i32>) -> i32 {
    let n = nums.len();
    let mut max_left = nums[0];
    let mut partition_index = 0;
    let mut max_so_far = nums[0];

    for i in 1..n {
        if nums[i] < max_left {
            partition_index = i;
            max_left = max_so_far;
        } else {
            max_so_far = max_so_far.max(nums[i]);
        }
    }
    (partition_index + 1) as i32
}
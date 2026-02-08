pub fn range_sum(nums: Vec<i32>, n: i32, left: i32, right: i32) -> i32 {
    let mut sums = vec![];
    let size = nums.len();

    for i in 0..size {
        let mut curr_sum = 0;
        for j in i..size {
            curr_sum += nums[j];
            sums.push(curr_sum);
        }
    }

    sums.sort();
    let mod_val = 1_000_000_007;
    let mut result = 0;

    for i in (left - 1)..right {
        result = (result + sums[i as usize]) % mod_val;
    }

    result
}
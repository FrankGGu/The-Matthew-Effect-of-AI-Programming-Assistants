pub fn split_array(nums: Vec<i32>, k: i32) -> i32 {
    let (mut left, mut right) = (0, nums.iter().sum::<i32>());
    while left < right {
        let mid = left + (right - left) / 2;
        if can_split(&nums, mid, k) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    left
}

fn can_split(nums: &Vec<i32>, max_sum: i32, k: i32) -> bool {
    let mut count = 1;
    let mut current_sum = 0;
    for &num in nums {
        current_sum += num;
        if current_sum > max_sum {
            count += 1;
            current_sum = num;
            if count > k {
                return false;
            }
        }
    }
    true
}
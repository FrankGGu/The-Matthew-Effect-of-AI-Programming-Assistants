pub fn can_form_groups(nums: Vec<i32>, groups: i32) -> bool {
    let total_sum: i32 = nums.iter().sum();
    if total_sum % groups != 0 {
        return false;
    }
    let target = total_sum / groups;
    let mut nums = nums;
    nums.sort_unstable_by(|a, b| b.cmp(a));
    let mut group_sums = vec![0; groups as usize];

    fn backtrack(nums: &mut Vec<i32>, group_sums: &mut Vec<i32>, target: i32, index: usize) -> bool {
        if index == nums.len() {
            return group_sums.iter().all(|&s| s == target);
        }
        for i in 0..group_sums.len() {
            if group_sums[i] + nums[index] <= target {
                group_sums[i] += nums[index];
                if backtrack(nums, group_sums, target, index + 1) {
                    return true;
                }
                group_sums[i] -= nums[index];
            }
            if group_sums[i] == 0 {
                break;
            }
        }
        false
    }

    backtrack(&mut nums, &mut group_sums, target, 0)
}
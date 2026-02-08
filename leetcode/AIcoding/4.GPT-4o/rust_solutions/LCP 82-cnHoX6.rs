pub fn find_target_sum_ways(nums: Vec<i32>, target: i32) -> i32 {
    use std::collections::HashMap;

    fn dfs(nums: &Vec<i32>, target: i32, index: usize, memo: &mut HashMap<(usize, i32), i32>) -> i32 {
        if index == nums.len() {
            return if target == 0 { 1 } else { 0 };
        }

        if let Some(&count) = memo.get(&(index, target)) {
            return count;
        }

        let add = dfs(nums, target - nums[index], index + 1, memo);
        let subtract = dfs(nums, target + nums[index], index + 1, memo);

        memo.insert((index, target), add + subtract);
        add + subtract
    }

    let mut memo = HashMap::new();
    dfs(&nums, target, 0, &mut memo)
}
impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_incompatity(mut nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut result = i32::MAX;

        if n % k != 0 {
            return -1;
        }

        let group_size = n / k;

        nums.sort();

        let mut used = vec![false; n];

        fn backtrack(
            nums: &Vec<i32>,
            used: &mut Vec<bool>,
            start: usize,
            current_group: &mut Vec<i32>,
            group_size: usize,
            target: i32,
            result: &mut i32,
        ) {
            if current_group.len() == group_size {
                if *current_group.iter().sum::<i32>() == target {
                    *result = std::cmp::min(*result, current_group.iter().max().unwrap() - current_group.iter().min().unwrap());
                }
                return;
            }

            for i in start..nums.len() {
                if !used[i] && (!current_group.is_empty() && nums[i] == current_group.last().unwrap()) {
                    continue;
                }
                if !used[i] && (current_group.is_empty() || nums[i] > current_group.last().unwrap()) {
                    used[i] = true;
                    current_group.push(nums[i]);
                    backtrack(nums, used, i + 1, current_group, group_size, target, result);
                    current_group.pop();
                    used[i] = false;
                }
            }
        }

        fn dfs(
            nums: &Vec<i32>,
            used: &mut Vec<bool>,
            groups: usize,
            group_size: usize,
            result: &mut i32,
        ) {
            if groups == k {
                *result = 0;
                return;
            }

            let mut current_group = vec![];
            let mut seen = HashSet::new();
            for i in 0..nums.len() {
                if !used[i] {
                    if current_group.is_empty() {
                        used[i] = true;
                        current_group.push(nums[i]);
                        dfs(nums, used, groups + 1, group_size, result);
                        current_group.pop();
                        used[i] = false;
                    } else if nums[i] > current_group.last().unwrap() && !seen.contains(&nums[i]) {
                        seen.insert(nums[i]);
                        used[i] = true;
                        current_group.push(nums[i]);
                        backtrack(nums, used, i + 1, &mut current_group, group_size, current_group.iter().sum(), result);
                        current_group.pop();
                        used[i] = false;
                    }
                }
            }
        }

        dfs(&nums, &mut used, 0, group_size, &mut result);

        if result == i32::MAX {
            -1
        } else {
            result
        }
    }
}
}
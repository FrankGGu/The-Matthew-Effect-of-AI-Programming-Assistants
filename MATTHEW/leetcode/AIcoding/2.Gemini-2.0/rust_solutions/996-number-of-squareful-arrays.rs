impl Solution {
    pub fn num_squareful_perms(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut count = 0;
        let mut used = vec![false; nums.len()];
        let mut perm = Vec::new();

        fn is_square(n: i32) -> bool {
            let root = (n as f64).sqrt() as i32;
            root * root == n
        }

        fn backtrack(nums: &Vec<i32>, used: &mut Vec<bool>, perm: &mut Vec<i32>, count: &mut i32) {
            if perm.len() == nums.len() {
                *count += 1;
                return;
            }

            for i in 0..nums.len() {
                if used[i] || (i > 0 && nums[i] == nums[i - 1] && !used[i - 1]) {
                    continue;
                }

                if perm.len() > 0 && !is_square(perm.last().unwrap() + nums[i]) {
                    continue;
                }

                used[i] = true;
                perm.push(nums[i]);
                backtrack(nums, used, perm, count);
                perm.pop();
                used[i] = false;
            }
        }

        backtrack(&nums, &mut used, &mut perm, &mut count);
        count
    }
}
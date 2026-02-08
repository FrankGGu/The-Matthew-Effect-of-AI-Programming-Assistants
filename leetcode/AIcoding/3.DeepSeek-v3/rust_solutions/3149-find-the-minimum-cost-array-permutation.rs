impl Solution {
    pub fn find_permutation(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut used = vec![false; n];
        let mut path = Vec::new();
        let mut min_cost = i32::MAX;
        let mut result = Vec::new();

        Self::backtrack(&nums, &mut used, &mut path, &mut min_cost, &mut result);

        result
    }

    fn backtrack(
        nums: &Vec<i32>,
        used: &mut Vec<bool>,
        path: &mut Vec<i32>,
        min_cost: &mut i32,
        result: &mut Vec<i32>,
    ) {
        if path.len() == nums.len() {
            let cost = Self::calculate_cost(&path, nums);
            if cost < *min_cost {
                *min_cost = cost;
                *result = path.clone();
            }
            return;
        }

        for i in 0..nums.len() {
            if !used[i] {
                used[i] = true;
                path.push(i as i32);
                Self::backtrack(nums, used, path, min_cost, result);
                path.pop();
                used[i] = false;
            }
        }
    }

    fn calculate_cost(perm: &Vec<i32>, nums: &Vec<i32>) -> i32 {
        let mut cost = 0;
        for i in 0..perm.len() {
            let j = (i + 1) % perm.len();
            cost += (perm[i] - nums[perm[j] as usize]).abs();
        }
        cost
    }
}
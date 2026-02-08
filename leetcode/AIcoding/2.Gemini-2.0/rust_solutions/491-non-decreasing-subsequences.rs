impl Solution {
    pub fn find_subsequences(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut res: std::collections::HashSet<Vec<i32>> = std::collections::HashSet::new();
        let mut cur: Vec<i32> = Vec::new();
        Self::backtrack(&nums, 0, &mut cur, &mut res);
        res.into_iter().collect()
    }

    fn backtrack(nums: &Vec<i32>, start: usize, cur: &mut Vec<i32>, res: &mut std::collections::HashSet<Vec<i32>>) {
        if cur.len() >= 2 {
            res.insert(cur.clone());
        }

        for i in start..nums.len() {
            if !cur.is_empty() && nums[i] < *cur.last().unwrap() {
                continue;
            }

            cur.push(nums[i]);
            Self::backtrack(nums, i + 1, cur, res);
            cur.pop();
        }
    }
}
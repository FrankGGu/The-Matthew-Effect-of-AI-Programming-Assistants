impl Solution {
    pub fn can_reach_zero(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut visited = vec![false; n];
        let mut q = std::collections::VecDeque::new();

        if nums[0] == 0 {
            return true;
        }

        q.push_back(0);
        visited[0] = true;

        while !q.is_empty() {
            let curr = q.pop_front().unwrap();
            let next1 = (curr as i32 + nums[curr]) as usize;
            let next2 = (curr as i32 - nums[curr]) as usize;

            if next1 < n && !visited[next1] {
                if nums[next1] == 0 {
                    return true;
                }
                q.push_back(next1);
                visited[next1] = true;
            }

            if next2 < n && !visited[next2] {
                if nums[next2] == 0 {
                    return true;
                }
                q.push_back(next2);
                visited[next2] = true;
            }
        }

        false
    }
}
impl Solution {
    pub fn can_reach(nums: Vec<i32>, start: i32) -> bool {
        let n = nums.len();
        let mut visited = vec![false; n];
        let mut queue = std::collections::VecDeque::new();
        queue.push_back(start as usize);
        visited[start as usize] = true;

        while let Some(curr) = queue.pop_front() {
            if nums[curr] == 0 {
                return true;
            }

            let next1 = (curr as i32 + nums[curr]) as usize % n;
            let next2 = (curr as i32 - nums[curr] + n as i32) as usize % n;

            if !visited[next1] {
                visited[next1] = true;
                queue.push_back(next1);
            }

            if !visited[next2] {
                visited[next2] = true;
                queue.push_back(next2);
            }
        }

        false
    }
}
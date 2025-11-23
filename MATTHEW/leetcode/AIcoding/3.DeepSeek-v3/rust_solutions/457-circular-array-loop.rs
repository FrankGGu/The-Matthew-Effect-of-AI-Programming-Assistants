impl Solution {
    pub fn circular_array_loop(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut visited = vec![false; n];
        for i in 0..n {
            if visited[i] {
                continue;
            }
            visited[i] = true;
            let mut slow = i;
            let mut fast = i;
            loop {
                slow = ((slow as i32 + nums[slow]) % n as i32 + n as i32) as usize % n;
                if nums[slow] * nums[i] <= 0 {
                    break;
                }
                fast = ((fast as i32 + nums[fast]) % n as i32 + n as i32) as usize % n;
                if nums[fast] * nums[i] <= 0 {
                    break;
                }
                fast = ((fast as i32 + nums[fast]) % n as i32 + n as i32) as usize % n;
                if nums[fast] * nums[i] <= 0 {
                    break;
                }
                if slow == fast {
                    if slow == ((slow as i32 + nums[slow]) % n as i32 + n as i32) as usize % n {
                        break;
                    }
                    return true;
                }
            }
            let mut j = i;
            while j != slow {
                visited[j] = true;
                j = ((j as i32 + nums[j]) % n as i32 + n as i32) as usize % n;
            }
        }
        false
    }
}
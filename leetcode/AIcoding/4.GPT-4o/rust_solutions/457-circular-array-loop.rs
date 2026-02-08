impl Solution {
    pub fn circular_array_loop(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut visited = vec![false; n];

        for i in 0..n {
            if visited[i] {
                continue;
            }

            let mut slow = i;
            let mut fast = i;
            let direction = nums[i] >= 0;

            while !visited[slow] {
                visited[slow] = true;
                slow = (slow as i32 + nums[slow]).rem_euclid(n as i32) as usize;

                if (nums[slow] >= 0) != direction {
                    break;
                }

                fast = (fast as i32 + nums[fast]).rem_euclid(n as i32) as usize;
                fast = (fast as i32 + nums[fast]).rem_euclid(n as i32) as usize;

                if slow == fast {
                    if slow == (slow as i32 + nums[slow]).rem_euclid(n as i32) as usize {
                        break;
                    }
                    return true;
                }
            }
        }
        false
    }
}
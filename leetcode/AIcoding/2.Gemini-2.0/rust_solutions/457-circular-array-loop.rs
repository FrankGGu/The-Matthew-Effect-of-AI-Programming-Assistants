impl Solution {
    pub fn circular_array_loop(nums: Vec<i32>) -> bool {
        let n = nums.len();
        for i in 0..n {
            let mut slow = i;
            let mut fast = i;
            let mut is_positive = nums[i] > 0;

            loop {
                slow = Solution::next_index(slow, nums[slow], n);
                if is_positive != (nums[slow] > 0) {
                    break;
                }

                fast = Solution::next_index(fast, nums[fast], n);
                if is_positive != (nums[fast] > 0) {
                    break;
                }
                fast = Solution::next_index(fast, nums[fast], n);
                if is_positive != (nums[fast] > 0) {
                    break;
                }

                if slow == fast {
                    if slow == Solution::next_index(slow, nums[slow], n) {
                        break;
                    }
                    return true;
                }

                if slow == -1 || fast == -1 {
                    break;
                }
            }
        }

        false
    }

    fn next_index(i: usize, val: i32, n: usize) -> usize {
        let next = ((i as i32 + val) % (n as i32)) as i32;
        if next < 0 {
            (next + n as i32) as usize
        } else {
            next as usize
        }
    }
}
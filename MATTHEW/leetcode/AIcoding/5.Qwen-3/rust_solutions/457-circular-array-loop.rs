impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn is_circular_array_loop(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut visited = HashSet::new();

        for i in 0..n {
            if visited.contains(&i) {
                continue;
            }
            let mut slow = i;
            let mut fast = i;
            let direction = nums[i] > 0;

            loop {
                slow = next_index(slow, &nums);
                if !is_same_direction(direction, nums[slow]) || slow == i {
                    break;
                }

                fast = next_index(fast, &nums);
                if !is_same_direction(direction, nums[fast]) || fast == i {
                    break;
                }

                fast = next_index(fast, &nums);
                if !is_same_direction(direction, nums[fast]) || fast == i {
                    break;
                }

                if slow == fast {
                    return true;
                }
            }

            let mut j = i;
            while !visited.contains(&j) {
                visited.insert(j);
                j = next_index(j, &nums);
            }
        }

        false
    }

    fn next_index(i: usize, nums: &[i32]) -> usize {
        let n = nums.len();
        let step = nums[i] as isize;
        let next = (i as isize + step) % n as isize;
        if next < 0 {
            next + n as isize
        } else {
            next
        } as usize
    }

    fn is_same_direction(a: bool, b: i32) -> bool {
        if a && b > 0 {
            true
        } else if !a && b < 0 {
            true
        } else {
            false
        }
    }
}
}
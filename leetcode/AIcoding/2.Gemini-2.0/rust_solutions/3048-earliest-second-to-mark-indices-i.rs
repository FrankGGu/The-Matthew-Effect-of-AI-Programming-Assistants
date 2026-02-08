impl Solution {
    pub fn earliest_second_to_mark_indices(nums: Vec<i32>, change_indices: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = change_indices.len();

        fn check(mid: i32, nums: &Vec<i32>, change_indices: &Vec<i32>, n: usize, m: usize) -> bool {
            let mut last_pos = vec![0; n];
            for i in 0..mid as usize {
                last_pos[(change_indices[i] - 1) as usize] = i + 1;
            }

            for i in 0..n {
                if last_pos[i] == 0 {
                    return false;
                }
            }

            let mut marked = vec![false; n];
            let mut ops = 0;
            for i in 0..mid as usize {
                let idx = (change_indices[i] - 1) as usize;
                if last_pos[idx] == i + 1 {
                    if nums[idx] as i32 > ops {
                        return false;
                    }
                    ops -= nums[idx] as i32;
                    marked[idx] = true;
                } else {
                    ops += 1;
                }
            }

            for i in 0..n {
                if !marked[i] {
                    return false;
                }
            }

            true
        }

        let mut left = 1;
        let mut right = m as i32;
        let mut ans = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            if check(mid, &nums, &change_indices, n, m) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        ans
    }
}
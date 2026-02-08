impl Solution {
    pub fn earliest_second_to_mark_indices(nums: Vec<i32>, change_indices: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = change_indices.len();

        fn check(mid: i32, nums: &Vec<i32>, change_indices: &Vec<i32>, n: usize, m: usize) -> bool {
            let mut last = vec![0; n];
            for i in 0..mid as usize {
                last[(change_indices[i] - 1) as usize] = i + 1;
            }

            let mut cnt = 0;
            let mut ops = 0;
            for i in 1..=n {
                if last[i - 1] == 0 {
                    continue;
                }
                if nums[i - 1] > mid as i32 {
                    return false;
                }

                if nums[i - 1] > ops {
                    cnt += 1;
                    ops = 0;
                } else {
                    ops -= nums[i - 1];
                }

                ops += 1;
            }
            ops >= cnt
        }

        let mut l = 1;
        let mut r = m as i32;
        let mut ans = -1;

        while l <= r {
            let mid = l + (r - l) / 2;
            if check(mid, &nums, &change_indices, n, m) {
                ans = mid;
                r = mid - 1;
            } else {
                l = mid + 1;
            }
        }

        ans
    }
}
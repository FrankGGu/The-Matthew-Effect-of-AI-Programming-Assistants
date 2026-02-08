impl Solution {
    pub fn earliest_second_to_mark_indices(nums: Vec<i32>, change_indices: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = change_indices.len();
        let mut left = 1;
        let mut right = m as i32;
        let mut answer = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            if Self::is_possible(&nums, &change_indices, mid as usize) {
                answer = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        answer
    }

    fn is_possible(nums: &[i32], change_indices: &[i32], max_s: usize) -> bool {
        let n = nums.len();
        let mut last_occurrence = vec![-1; n];
        for (s, &idx) in change_indices[..max_s].iter().enumerate() {
            let idx = idx as usize - 1;
            last_occurrence[idx] = s as i32;
        }

        for (i, &last) in last_occurrence.iter().enumerate() {
            if last == -1 {
                return false;
            }
            if nums[i] == 0 {
                continue;
            }
            let required = nums[i] as usize;
            if last as usize + 1 < required {
                return false;
            }
        }

        let mut marked = 0;
        for s in 0..max_s {
            let idx = change_indices[s] as usize - 1;
            if last_occurrence[idx] == s as i32 {
                if nums[idx] as usize > marked {
                    return false;
                }
                marked -= nums[idx] as usize;
                marked += 1;
            } else {
                marked += 1;
            }
        }

        true
    }
}
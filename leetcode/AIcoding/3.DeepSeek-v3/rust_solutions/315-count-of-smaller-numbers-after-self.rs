impl Solution {
    pub fn count_smaller(nums: Vec<i32>) -> Vec<i32> {
        let mut res = vec![0; nums.len()];
        let mut indices: Vec<usize> = (0..nums.len()).collect();
        let mut temp = vec![0; nums.len()];
        let mut temp_indices = vec![0; nums.len()];

        Self::merge_sort(&nums, &mut indices, &mut res, &mut temp, &mut temp_indices, 0, nums.len());
        res
    }

    fn merge_sort(
        nums: &Vec<i32>,
        indices: &mut Vec<usize>,
        res: &mut Vec<i32>,
        temp: &mut Vec<i32>,
        temp_indices: &mut Vec<usize>,
        left: usize,
        right: usize,
    ) {
        if right - left <= 1 {
            return;
        }

        let mid = left + (right - left) / 2;
        Self::merge_sort(nums, indices, res, temp, temp_indices, left, mid);
        Self::merge_sort(nums, indices, res, temp, temp_indices, mid, right);

        let mut i = left;
        let mut j = mid;
        let mut k = left;
        let mut right_count = 0;

        while i < mid && j < right {
            if nums[indices[i]] <= nums[indices[j]] {
                res[indices[i]] += right_count;
                temp[k] = nums[indices[i]];
                temp_indices[k] = indices[i];
                i += 1;
            } else {
                right_count += 1;
                temp[k] = nums[indices[j]];
                temp_indices[k] = indices[j];
                j += 1;
            }
            k += 1;
        }

        while i < mid {
            res[indices[i]] += right_count;
            temp[k] = nums[indices[i]];
            temp_indices[k] = indices[i];
            i += 1;
            k += 1;
        }

        while j < right {
            temp[k] = nums[indices[j]];
            temp_indices[k] = indices[j];
            j += 1;
            k += 1;
        }

        for k in left..right {
            nums[indices[k]] = temp[k];
            indices[k] = temp_indices[k];
        }
    }
}
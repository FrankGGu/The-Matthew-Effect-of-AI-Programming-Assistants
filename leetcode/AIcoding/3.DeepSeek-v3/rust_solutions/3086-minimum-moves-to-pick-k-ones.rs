impl Solution {
    pub fn min_moves(nums: Vec<i32>, k: i32) -> i32 {
        let mut ones_indices = vec![];
        for (i, &num) in nums.iter().enumerate() {
            if num == 1 {
                ones_indices.push(i as i32);
            }
        }

        let n = ones_indices.len();
        let k = k as usize;
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + ones_indices[i];
        }

        let mut res = i32::MAX;
        let radius = (k as i32 - 1) / 2;

        for i in 0..=n - k {
            let j = i + k - 1;
            let mid = i + k / 2;
            let left = ones_indices[mid] - radius;
            let right = ones_indices[mid] + radius;

            let left_sum = left * (mid - i) as i32 - (prefix[mid] - prefix[i]);
            let right_sum = (prefix[j + 1] - prefix[mid + 1]) - right * (j - mid) as i32;

            res = res.min(left_sum + right_sum);
        }

        res
    }
}
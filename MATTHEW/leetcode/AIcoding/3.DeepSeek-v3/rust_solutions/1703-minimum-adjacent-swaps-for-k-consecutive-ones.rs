impl Solution {
    pub fn min_moves(nums: Vec<i32>, k: i32) -> i32 {
        let mut ones = Vec::new();
        for (i, &num) in nums.iter().enumerate() {
            if num == 1 {
                ones.push(i as i32);
            }
        }
        let n = ones.len();
        let k = k as usize;
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + ones[i];
        }
        let mut res = i32::MAX;
        let radius = (k - 1) / 2;
        for i in radius..n - k + 1 + radius {
            let left = i - radius;
            let right = i + radius + (k % 2 == 0) as usize;
            let right = right.min(n - 1);
            let total = (prefix[right + 1] - prefix[i + 1]) - (prefix[i + 1] - prefix[left]);
            let cost = total - (radius as i32) * (radius as i32 + 1);
            let cost = if k % 2 == 0 {
                cost - ones[i] - (radius as i32 + 1)
            } else {
                cost
            };
            res = res.min(cost);
        }
        res
    }
}
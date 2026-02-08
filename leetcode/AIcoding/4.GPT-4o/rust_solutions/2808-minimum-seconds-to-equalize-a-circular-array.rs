impl Solution {
    pub fn minimum_seconds(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut last = vec![-1; 100001];
        let mut max_interval = 0;

        for i in 0..n {
            if let Some(&prev) = last.get(nums[i] as usize) {
                max_interval = max_interval.max(i - prev);
            }
            last[nums[i] as usize] = i as i32;
        }

        for i in 0..100001 {
            if last[i] != -1 {
                max_interval = max_interval.max(n + last[i] - last[i as usize % n]);
            }
        }

        (max_interval + 1) / 2
    }
}
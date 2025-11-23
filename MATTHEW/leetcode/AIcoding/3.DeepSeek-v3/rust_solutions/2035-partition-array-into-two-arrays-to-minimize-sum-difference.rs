impl Solution {
    pub fn minimum_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len() / 2;
        let total = nums.iter().sum::<i32>();
        let mut left = vec![vec![]; n + 1];
        let mut right = vec![vec![]; n + 1];

        for mask in 0..1 << n {
            let mut sum = 0;
            let mut cnt = 0;
            for i in 0..n {
                if mask & (1 << i) != 0 {
                    sum += nums[i];
                    cnt += 1;
                }
            }
            left[cnt].push(sum);

            sum = 0;
            cnt = 0;
            for i in 0..n {
                if mask & (1 << i) != 0 {
                    sum += nums[n + i];
                    cnt += 1;
                }
            }
            right[cnt].push(sum);
        }

        for v in right.iter_mut() {
            v.sort_unstable();
        }

        let mut res = i32::MAX;
        for k in 0..=n {
            for &a in &left[k] {
                let target = (total - 2 * a) / 2;
                let v = &right[n - k];
                let idx = v.binary_search(&target).unwrap_or_else(|x| x);
                if idx < v.len() {
                    res = res.min((total - 2 * (a + v[idx])).abs());
                }
                if idx > 0 {
                    res = res.min((total - 2 * (a + v[idx - 1])).abs());
                }
            }
        }
        res
    }
}
impl Solution {
    pub fn max_balanced_subsequence_sum(nums: Vec<i32>) -> i64 {
        use std::collections::BTreeMap;

        let mut sorted_nums: Vec<(i32, usize)> = nums.iter().enumerate().map(|(i, &x)| (x - (i as i32), i)).collect();
        sorted_nums.sort_unstable();

        let mut bit: BTreeMap<usize, i64> = BTreeMap::new();

        let mut ans = i64::MIN;

        for &(val, i) in &sorted_nums {
            let query_val = i as usize;
            let mut sum = 0;
            let mut j = query_val;
            while j > 0 {
                if let Some(&v) = bit.get(&j) {
                    sum = sum.max(v);
                }
                if j & (j as isize - 1) as usize == 0 {
                   break;
                }
                j &= j - 1;
            }

            let new_sum = sum + nums[i] as i64;
            ans = ans.max(new_sum);

            let mut k = (i as usize) + 1;
            while k <= nums.len() {
                let current_val = *bit.get(&k).unwrap_or(&i64::MIN);
                if new_sum > current_val {
                    bit.insert(k, new_sum);
                } else {
                    break;
                }
                if k & (k as isize - 1) as usize == 0 {
                   break;
                }
                k += k & (k as isize * -1) as usize;
            }
        }

        ans.max(0)
    }
}
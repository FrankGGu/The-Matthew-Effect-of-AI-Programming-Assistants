impl Solution {
    pub fn beautiful_subsets(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort_unstable();
        let mut ans = 0;
        let offset = 1000;
        let mut freq_arr: Vec<i32> = vec![0; 2001];

        Self::backtrack(0, &nums, k, offset, &mut freq_arr, &mut ans);

        ans
    }

    fn backtrack(
        idx: usize,
        nums: &[i32],
        k: i32,
        offset: i32,
        freq_arr: &mut Vec<i32>,
        ans: &mut i32,
    ) {
        if idx == nums.len() {
            *ans += 1;
            return;
        }

        Self::backtrack(idx + 1, nums, k, offset, freq_arr, ans);

        let num = nums[idx];
        let target_val = num - k;

        if freq_arr[(target_val + offset) as usize] == 0 {
            freq_arr[(num + offset) as usize] += 1;
            Self::backtrack(idx + 1, nums, k, offset, freq_arr, ans);
            freq_arr[(num + offset) as usize] -= 1;
        }
    }
}
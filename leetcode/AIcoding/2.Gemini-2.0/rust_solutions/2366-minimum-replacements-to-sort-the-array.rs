impl Solution {
    pub fn minimum_replacements(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut last = nums[n - 1] as i64;
        let mut ans = 0;

        for i in (0..n - 1).rev() {
            let num = nums[i] as i64;
            if num > last {
                let k = (num + last - 1) / last;
                ans += k - 1;
                last = num / k;
            } else {
                last = num;
            }
        }

        ans
    }
}
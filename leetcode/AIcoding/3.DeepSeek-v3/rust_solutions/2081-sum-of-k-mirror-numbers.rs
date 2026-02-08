impl Solution {
    pub fn k_mirror(k: i32, n: i32) -> i64 {
        let mut count = 0;
        let mut sum = 0;
        let mut len = 1;
        while count < n {
            let mut nums = vec![0; len];
            Self::generate_mirrors(&mut nums, 0, len, k as i64, &mut count, &mut sum, n);
            len += 1;
        }
        sum
    }

    fn generate_mirrors(nums: &mut Vec<i64>, pos: usize, len: usize, k: i64, count: &mut i32, sum: &mut i64, n: i32) {
        if *count >= n {
            return;
        }
        if pos >= (len + 1) / 2 {
            let mut num = 0;
            for &digit in nums.iter() {
                num = num * k + digit;
            }
            if Self::is_palindrome(num) {
                *sum += num;
                *count += 1;
            }
            return;
        }
        let start = if pos == 0 { 1 } else { 0 };
        for d in start..k {
            nums[pos] = d;
            nums[len - 1 - pos] = d;
            Self::generate_mirrors(nums, pos + 1, len, k, count, sum, n);
        }
    }

    fn is_palindrome(mut num: i64) -> bool {
        if num < 10 {
            return true;
        }
        let original = num;
        let mut reversed = 0;
        while num > 0 {
            reversed = reversed * 10 + num % 10;
            num /= 10;
        }
        original == reversed
    }
}
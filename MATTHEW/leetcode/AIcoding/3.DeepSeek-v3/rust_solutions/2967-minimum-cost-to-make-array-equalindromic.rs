impl Solution {
    pub fn min_cost(nums: Vec<i32>) -> i64 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let median = nums[n / 2];

        fn is_palindrome(mut x: i32) -> bool {
            if x < 0 {
                return false;
            }
            let original = x;
            let mut reversed = 0;
            while x > 0 {
                reversed = reversed * 10 + x % 10;
                x /= 10;
            }
            original == reversed
        }

        let find_closest_palindrome = |x: i32| -> i32 {
            if is_palindrome(x) {
                return x;
            }
            let mut lower = x - 1;
            while lower >= 0 && !is_palindrome(lower) {
                lower -= 1;
            }
            let mut higher = x + 1;
            while !is_palindrome(higher) {
                higher += 1;
            }
            if lower < 0 {
                higher
            } else if x - lower <= higher - x {
                lower
            } else {
                higher
            }
        };

        let target = find_closest_palindrome(median);

        nums.iter().map(|&num| (num - target).abs() as i64).sum()
    }
}
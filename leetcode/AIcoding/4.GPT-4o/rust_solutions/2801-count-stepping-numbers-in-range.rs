impl Solution {
    pub fn count_stepping_numbers(low: i32, high: i32) -> i32 {
        let low = low as u32;
        let high = high as u32;
        let mut count = 0;

        fn dfs(num: u32, low: u32, high: u32, count: &mut i32) {
            if num >= low && num <= high {
                *count += 1;
            }
            if num == 0 || num > high {
                return;
            }
            let last_digit = num % 10;
            if last_digit > 0 {
                dfs(num * 10 + last_digit - 1, low, high, count);
            }
            if last_digit < 9 {
                dfs(num * 10 + last_digit + 1, low, high, count);
            }
        }

        for i in 0..10 {
            dfs(i, low, high, &mut count);
        }

        count
    }
}
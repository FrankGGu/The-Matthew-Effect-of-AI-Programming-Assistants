impl Solution {
    pub fn find_kth_digit(n: i32, k: i32) -> i32 {
        let mut k = k as i64;
        let mut digit_length = 1;
        let mut count = 9;
        let mut start = 1;

        while k > digit_length * count {
            k -= digit_length * count;
            digit_length += 1;
            count *= 10;
            start *= 10;
        }

        let num = start + (k - 1) / digit_length;
        let digit_index = (k - 1) % digit_length;

        num.to_string().chars().nth(digit_index as usize).unwrap().to_digit(10).unwrap() as i32
    }
}
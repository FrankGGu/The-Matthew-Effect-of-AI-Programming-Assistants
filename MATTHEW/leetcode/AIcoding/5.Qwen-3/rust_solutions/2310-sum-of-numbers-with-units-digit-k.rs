struct Solution;

impl Solution {
    pub fn minimum_numbers(a: i32, k: i32) -> i32 {
        if a == 0 {
            return 0;
        }
        if k == 0 {
            return if a % 10 == 0 { a / 10 } else { -1 };
        }
        let mut res = 0;
        let mut rem = a;
        while rem > 0 {
            if rem % 10 == k {
                res += 1;
                rem /= 10;
            } else {
                return -1;
            }
        }
        res
    }
}
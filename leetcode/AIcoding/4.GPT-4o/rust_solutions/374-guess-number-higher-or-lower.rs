pub struct Solution;

impl Solution {
    pub fn guess_number(n: i32) -> i32 {
        let mut low = 1;
        let mut high = n;

        while low <= high {
            let mid = low + (high - low) / 2;
            match guess(mid) {
                0 => return mid,
                1 => low = mid + 1,
                -1 => high = mid - 1,
                _ => unreachable!(),
            }
        }

        -1
    }
}
pub struct Solution;

impl Solution {
    pub fn guess_number(n: i32) -> i32 {
        let mut low = 1;
        let mut high = n;

        while low <= high {
            let mid = low + (high - low) / 2;
            let res = unsafe { guess(mid) };

            if res == 0 {
                return mid;
            } else if res == -1 {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        unreachable!() 
    }
}
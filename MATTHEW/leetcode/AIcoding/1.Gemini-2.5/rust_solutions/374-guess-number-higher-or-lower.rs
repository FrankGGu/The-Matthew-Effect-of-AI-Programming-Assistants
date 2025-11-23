unsafe fn guess(num: i32) -> i32 {
    panic!("The `guess` function is provided by LeetCode and should not be called in local tests without a mock.")
}

struct Solution;

impl Solution {
    unsafe fn guessNumber(n: i32) -> i32 {
        let mut low = 1;
        let mut high = n;

        while low <= high {
            let mid = low + (high - low) / 2;
            match guess(mid) {
                0 => return mid,
                -1 => high = mid - 1,
                1 => low = mid + 1,
                _ => unreachable!(),
            }
        }
        unreachable!()
    }
}
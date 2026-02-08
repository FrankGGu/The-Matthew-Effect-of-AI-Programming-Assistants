impl Solution {
    unsafe fn guessNumber(n: i32) -> i32 {
        let mut low: i64 = 1;
        let mut high: i64 = n as i64;

        while low <= high {
            let mid: i64 = low + (high - low) / 2;
            let res = guess(mid as i32);

            if res == 0 {
                return mid as i32;
            } else if res == -1 {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        0
    }
}

struct Solution;

unsafe fn guess(num: i32) -> i32 {
    let picked_number = 6; 
    if num > picked_number {
        -1
    } else if num < picked_number {
        1
    } else {
        0
    }
}
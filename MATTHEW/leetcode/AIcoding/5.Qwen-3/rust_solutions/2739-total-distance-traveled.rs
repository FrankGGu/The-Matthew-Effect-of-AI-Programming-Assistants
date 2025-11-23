struct Solution;

impl Solution {
    pub fn distance_traveled(mut d: i32, mut b: i32, mut s: i32) -> i32 {
        let mut total = 0;
        while d > 0 {
            if b > 0 {
                total += s;
                b -= 1;
                d -= 1;
            } else {
                break;
            }
        }
        total
    }
}
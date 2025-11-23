impl Solution {
    pub fn three_consecutive_odds(arr: Vec<i32>) -> bool {
        let mut consecutive_odds = 0;
        for &num in arr.iter() {
            if num % 2 != 0 {
                consecutive_odds += 1;
                if consecutive_odds == 3 {
                    return true;
                }
            } else {
                consecutive_odds = 0;
            }
        }
        false
    }
}
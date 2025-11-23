impl Solution {
    pub fn count_good_integers(low: i32, high: i32) -> i32 {
        let mut count = 0;
        for i in low..=high {
            if i.to_string().chars().all(|c| c == '0' || c == '1') {
                count += 1;
            }
        }
        count
    }
}
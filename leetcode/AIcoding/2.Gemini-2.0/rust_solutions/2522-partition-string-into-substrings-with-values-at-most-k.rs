impl Solution {
    pub fn partition_string(s: String, k: i32) -> i32 {
        let mut count = 1;
        let mut current_val = 0;
        for c in s.chars() {
            let val = (c as i32) - ('a' as i32) + 1;
            if val > k {
                return -1;
            }
            if current_val + val <= k {
                current_val += val;
            } else {
                count += 1;
                current_val = val;
            }
        }
        count
    }
}
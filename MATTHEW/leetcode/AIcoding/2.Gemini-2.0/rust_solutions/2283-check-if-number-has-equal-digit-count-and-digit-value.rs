impl Solution {
    pub fn digit_count(num: String) -> bool {
        let n = num.len();
        for i in 0..n {
            let count = num.chars().filter(|&c| (c as u8 - b'0') as usize == i).count();
            if count != (num.chars().nth(i).unwrap() as u8 - b'0') as usize {
                return false;
            }
        }
        true
    }
}
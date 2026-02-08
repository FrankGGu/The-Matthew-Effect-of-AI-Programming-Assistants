impl Solution {
    pub fn maximum_odd_binary_number(s: String) -> String {
        let count = s.chars().filter(|&c| c == '1').count();
        let mut res = String::new();
        for _ in 0..count - 1 {
            res.push('1');
        }
        for _ in 0..s.len() - count {
            res.push('0');
        }
        res.push('1');
        res
    }
}
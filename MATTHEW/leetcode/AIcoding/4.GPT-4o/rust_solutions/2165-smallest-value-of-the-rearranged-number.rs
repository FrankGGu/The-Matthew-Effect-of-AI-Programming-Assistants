impl Solution {
    pub fn smallest_rearranged_number(num: i64) -> i64 {
        let mut digits: Vec<_> = num.to_string().chars().collect();
        digits.sort();
        if let Some(pos) = digits.iter().position(|&c| c != '0') {
            let first = digits.remove(pos);
            digits.insert(0, first);
        }
        digits.iter().collect::<String>().parse::<i64>().unwrap()
    }
}
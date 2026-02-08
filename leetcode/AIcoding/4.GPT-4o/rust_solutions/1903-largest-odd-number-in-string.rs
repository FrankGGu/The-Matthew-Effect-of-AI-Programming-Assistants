impl Solution {
    pub fn largest_odd_number(num: String) -> String {
        num.chars().rev().take_while(|&c| c % 2 == 0).collect::<String>().chars().rev().collect::<String>().to_string()
    }
}
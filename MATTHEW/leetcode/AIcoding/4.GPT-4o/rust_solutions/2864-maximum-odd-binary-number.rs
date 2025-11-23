impl Solution {
    pub fn maximum_odd_binary_number(n: String) -> String {
        let mut ones = n.chars().filter(|&c| c == '1').count();
        let length = n.len();
        let mut result = String::new();

        if ones == 0 {
            return "0".to_string();
        }

        for _ in 0..length - 1 {
            result.push('1');
        }
        result.push('1'); // last bit is 1 for odd

        result.push_str(&"0".repeat(ones - 1));
        result
    }
}
impl Solution {
    pub fn maximum69_number(num: i32) -> i32 {
        let mut num_str = num.to_string().chars().collect::<Vec<char>>();
        for i in 0..num_str.len() {
            if num_str[i] == '6' {
                num_str[i] = '9';
                break;
            }
        }
        num_str.into_iter().collect::<String>().parse().unwrap()
    }
}
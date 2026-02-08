impl Solution {
    pub fn maximum69_number (num: i32) -> i32 {
        let mut s = num.to_string();
        if let Some(index) = s.find('6') {
            s.replace_range(index..index+1, "9");
        }
        s.parse::<i32>().unwrap()
    }
}
impl Solution {
    pub fn min_max_difference(num: i32) -> i32 {
        let num_str = num.to_string();
        let min_num = num_str.replace('9', '0').parse::<i32>().unwrap();
        let max_num = num_str.replace(num_str.chars().next().unwrap(), '9').parse::<i32>().unwrap();
        max_num - min_num
    }
}
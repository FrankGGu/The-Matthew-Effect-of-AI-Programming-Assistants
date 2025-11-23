impl Solution {
    pub fn the_two_sneaky_numbers(n: i32) -> i32 {
        let mut count = 0;
        for i in 1..=n {
            if n % i == 0 {
                if i.to_string().chars().collect::<Vec<char>>().iter().all(|&c| c == '1' || c == '2' || c == '3' || c == '4' || c == '5' || c == '6' || c == '7' || c == '8' || c == '9') {
                    count += 1;
                }
            }
        }
        count
    }
}
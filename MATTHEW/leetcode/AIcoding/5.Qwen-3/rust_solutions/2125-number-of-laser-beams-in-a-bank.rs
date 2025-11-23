struct Solution;

impl Solution {
    pub fn number_of_lasers(bank: Vec<String>) -> i32 {
        let mut prev = 0;
        let mut result = 0;

        for row in bank {
            let count = row.chars().filter(|&c| c == '1').count();
            if count > 0 {
                result += prev * count;
                prev = count;
            }
        }

        result as i32
    }
}
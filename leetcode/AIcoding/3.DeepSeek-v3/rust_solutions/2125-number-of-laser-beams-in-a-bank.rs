impl Solution {
    pub fn number_of_beams(bank: Vec<String>) -> i32 {
        let mut prev = 0;
        let mut total = 0;
        for row in bank {
            let current = row.chars().filter(|&c| c == '1').count() as i32;
            if current > 0 {
                total += prev * current;
                prev = current;
            }
        }
        total
    }
}
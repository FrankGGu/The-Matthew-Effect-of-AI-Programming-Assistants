impl Solution {
    pub fn number_of_beams(bank: Vec<String>) -> i32 {
        let mut prev = 0;
        let mut total_beams = 0;

        for row in bank {
            let count = row.chars().filter(|&c| c == '1').count();
            if count > 0 {
                total_beams += prev * count;
                prev = count;
            }
        }

        total_beams
    }
}
impl Solution {
    pub fn find_even_numbers(digits: Vec<i32>) -> Vec<i32> {
        let mut digit_counts = [0; 10];
        for &digit in &digits {
            digit_counts[digit as usize] += 1;
        }

        let mut result = Vec::new();

        for num in (100..=998).step_by(2) {
            let h = num / 100;
            let t = (num / 10) % 10;
            let u = num % 10;

            let mut temp_counts = [0; 10];
            temp_counts[h as usize] += 1;
            temp_counts[t as usize] += 1;
            temp_counts[u as usize] += 1;

            let mut possible = true;
            for i in 0..10 {
                if temp_counts[i] > digit_counts[i] {
                    possible = false;
                    break;
                }
            }

            if possible {
                result.push(num);
            }
        }

        result
    }
}
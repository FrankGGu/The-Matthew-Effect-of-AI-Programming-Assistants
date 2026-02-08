struct Solution;

impl Solution {
    pub fn find_even_numbers(digits: Vec<i32>) -> Vec<i32> {
        let mut counts = [0; 10];
        for &digit in &digits {
            counts[digit as usize] += 1;
        }

        let mut result = Vec::new();

        for num in 100..=999 {
            if num % 2 != 0 {
                continue;
            }

            let c = num % 10;
            let b = (num / 10) % 10;
            let a = num / 100;

            let mut current_num_counts = [0; 10];
            current_num_counts[a as usize] += 1;
            current_num_counts[b as usize] += 1;
            current_num_counts[c as usize] += 1;

            let mut can_form = true;
            for i in 0..10 {
                if current_num_counts[i] > counts[i] {
                    can_form = false;
                    break;
                }
            }

            if can_form {
                result.push(num);
            }
        }

        result
    }
}
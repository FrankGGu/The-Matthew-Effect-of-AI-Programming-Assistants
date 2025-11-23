impl Solution {
    pub fn find_3_digit_even_numbers(digits: Vec<i32>) -> Vec<i32> {
        use std::collections::HashSet;
        let mut count = [0; 10];
        for &d in &digits {
            count[d as usize] += 1;
        }

        let mut result = HashSet::new();
        for i in 100..=999 {
            if i % 2 != 0 {
                continue;
            }
            let mut temp_count = [0; 10];
            let mut num = i;
            temp_count[(num % 10) as usize] += 1;
            num /= 10;
            temp_count[(num % 10) as usize] += 1;
            num /= 10;
            temp_count[(num % 10) as usize] += 1;

            let mut possible = true;
            for j in 0..10 {
                if temp_count[j] > count[j] {
                    possible = false;
                    break;
                }
            }

            if possible {
                result.insert(i);
            }
        }

        let mut sorted_result: Vec<i32> = result.into_iter().collect();
        sorted_result.sort();
        sorted_result
    }
}
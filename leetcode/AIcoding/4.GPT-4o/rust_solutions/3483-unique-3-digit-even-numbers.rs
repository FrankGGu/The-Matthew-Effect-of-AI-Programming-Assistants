impl Solution {
    pub fn find_even_numbers(digits: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut count = vec![0; 10];

        for &d in &digits {
            count[d as usize] += 1;
        }

        for i in 100..1000 {
            if i % 2 == 0 {
                let mut temp_count = count.clone();
                let mut valid = true;
                for digit in i.to_string().chars() {
                    let d = digit.to_digit(10).unwrap() as usize;
                    if temp_count[d] == 0 {
                        valid = false;
                        break;
                    }
                    temp_count[d] -= 1;
                }
                if valid {
                    result.push(i);
                }
            }
        }

        result
    }
}
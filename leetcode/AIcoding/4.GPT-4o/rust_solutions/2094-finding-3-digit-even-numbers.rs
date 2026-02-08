impl Solution {
    pub fn find_even_numbers(digits: Vec<i32>) -> Vec<i32> {
        let mut count = [0; 10];
        for &digit in &digits {
            count[digit as usize] += 1;
        }
        let mut result = Vec::new();

        for i in 1..10 {
            if count[i] > 0 {
                for j in 0..10 {
                    if count[j] > 0 {
                        for k in (0..10).filter(|&x| x % 2 == 0 && count[x] > 0) {
                            if k == 0 && j == 0 {
                                continue;
                            }
                            let mut temp_count = count.clone();
                            temp_count[i] -= 1;
                            temp_count[j] -= 1;
                            temp_count[k] -= 1;
                            if temp_count[i] >= 0 && temp_count[j] >= 0 && temp_count[k] >= 0 {
                                result.push(i * 100 + j * 10 + k);
                            }
                        }
                    }
                }
            }
        }

        result.sort();
        result
    }
}
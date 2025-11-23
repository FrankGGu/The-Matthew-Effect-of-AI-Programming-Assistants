impl Solution {
    pub fn largest_multiple_of_three(digits: Vec<i32>) -> String {
        let mut sum: i32 = 0;
        let mut count: [i32; 10] = [0; 10];
        for &d in &digits {
            sum += d;
            count[d as usize] += 1;
        }

        let mut remove_one: Vec<i32> = Vec::new();
        let mut remove_two: Vec<i32> = Vec::new();

        for i in 1..10 {
            if i % 3 == 1 {
                for _ in 0..count[i as usize] {
                    remove_one.push(i);
                }
            } else if i % 3 == 2 {
                for _ in 0..count[i as usize] {
                    remove_two.push(i);
                }
            }
        }

        if sum % 3 == 1 {
            if !remove_one.is_empty() {
                count[remove_one[0] as usize] -= 1;
            } else if remove_two.len() >= 2 {
                count[remove_two[0] as usize] -= 1;
                count[remove_two[1] as usize] -= 1;
            } else {
                return "0".to_string();
            }
        } else if sum % 3 == 2 {
            if !remove_two.is_empty() {
                count[remove_two[0] as usize] -= 1;
            } else if remove_one.len() >= 2 {
                count[remove_one[0] as usize] -= 1;
                count[remove_one[1] as usize] -= 1;
            } else {
                return "0".to_string();
            }
        }

        let mut result: Vec<i32> = Vec::new();
        for i in (0..10).rev() {
            for _ in 0..count[i as usize] {
                result.push(i);
            }
        }

        if result.is_empty() {
            return "".to_string();
        }

        if result[0] == 0 {
            return "0".to_string();
        }

        result.iter().map(|&x| x.to_string()).collect::<String>()
    }
}
impl Solution {
    pub fn largest_palindromic(num: String) -> String {
        let mut counts = [0; 10];
        for c in num.chars() {
            counts[c as usize - '0' as usize] += 1;
        }

        let mut left = String::new();
        for i in (1..10).rev() {
            while counts[i] > 1 {
                left.push_str(&i.to_string());
                counts[i] -= 2;
            }
        }
        while counts[0] > 1 && !left.is_empty() {
            left.push_str("0");
            counts[0] -= 2;
        }

        let mut middle = String::new();
        for i in (0..10).rev() {
            if counts[i] > 0 {
                middle.push_str(&i.to_string());
                break;
            }
        }

        let mut right = left.chars().rev().collect::<String>();

        if left.is_empty() && middle.is_empty() && counts[0] > 0 {
            return "0".to_string();
        }

        if left.is_empty() && middle.is_empty() {
            return "".to_string();
        }

        if left.is_empty() && middle.len() > 0 {
            return middle.to_string();
        }

        if left.is_empty() && counts[0] > 0 {
            return "0".to_string()
        }

        if left.len() > 0 {
            left + &middle + &right
        } else {
            middle
        }
    }
}
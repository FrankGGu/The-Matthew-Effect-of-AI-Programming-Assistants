impl Solution {
    pub fn next_greater_element(n: i32) -> i32 {
        let mut digits: Vec<char> = n.to_string().chars().collect();
        let len = digits.len();
        let mut i = len - 2;

        while i < len && digits[i] >= digits[i + 1] {
            if i == 0 {
                break;
            }
            i -= 1;
        }

        if i == len || digits[i] >= digits[i + 1] {
            return -1;
        }

        let mut j = len - 1;
        while j > i && digits[j] <= digits[i] {
            j -= 1;
        }

        digits.swap(i, j);
        digits[i + 1..].reverse();

        match digits.iter().collect::<String>().parse::<i32>() {
            Ok(num) => num,
            Err(_) => -1,
        }
    }
}
impl Solution {
    pub fn next_greater_element(n: i32) -> i32 {
        let mut digits: Vec<u8> = n.to_string().bytes().map(|b| b - b'0').collect();
        let len = digits.len();

        let mut i = len - 2;
        while i >= 0 && digits[i] >= digits[i + 1] {
            if i == 0 {
                return -1;
            }
            i -= 1;
        }

        let mut j = len - 1;
        while j > i && digits[j] <= digits[i] {
            j -= 1;
        }

        digits.swap(i as usize, j as usize);
        digits[i as usize + 1..].reverse();

        let mut result: i64 = 0;
        for &digit in &digits {
            result = result * 10 + digit as i64;
        }

        if result > i32::MAX as i64 {
            return -1;
        }

        result as i32
    }
}
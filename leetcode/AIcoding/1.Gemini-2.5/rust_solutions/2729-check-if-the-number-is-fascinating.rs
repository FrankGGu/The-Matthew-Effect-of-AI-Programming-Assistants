impl Solution {
    pub fn is_fascinating(n: i32) -> bool {
        let n2 = n * 2;
        let n3 = n * 3;

        let s = format!("{}{}{}", n, n2, n3);

        if s.len() != 9 {
            return false;
        }

        let mut seen = [false; 10]; 

        for c in s.chars() {
            let digit = c.to_digit(10).unwrap() as usize;

            if digit == 0 || seen[digit] {
                return false;
            }
            seen[digit] = true;
        }

        true
    }
}
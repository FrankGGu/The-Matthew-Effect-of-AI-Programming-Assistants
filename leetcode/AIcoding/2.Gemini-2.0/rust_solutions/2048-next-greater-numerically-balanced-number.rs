impl Solution {
    pub fn next_greater_numerically_balanced_number(n: i32) -> i32 {
        let mut num = n + 1;
        while !Self::is_balanced(num) {
            num += 1;
        }
        num
    }

    fn is_balanced(n: i32) -> bool {
        let s = n.to_string();
        let mut counts = [0; 10];
        for c in s.chars() {
            let digit = c.to_digit(10).unwrap() as usize;
            counts[digit] += 1;
        }

        for i in 0..10 {
            if counts[i] > 0 && counts[i] != i as i32 {
                return false;
            }
        }

        true
    }
}
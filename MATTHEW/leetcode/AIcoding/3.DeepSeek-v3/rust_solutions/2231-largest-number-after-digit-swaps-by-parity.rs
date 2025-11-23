impl Solution {
    pub fn largest_integer(num: i32) -> i32 {
        let mut digits: Vec<char> = num.to_string().chars().collect();
        let n = digits.len();

        for i in 0..n {
            for j in i + 1..n {
                let a = digits[i].to_digit(10).unwrap();
                let b = digits[j].to_digit(10).unwrap();
                if (a % 2 == b % 2) && (b > a) {
                    digits.swap(i, j);
                }
            }
        }

        digits.into_iter().collect::<String>().parse().unwrap()
    }
}
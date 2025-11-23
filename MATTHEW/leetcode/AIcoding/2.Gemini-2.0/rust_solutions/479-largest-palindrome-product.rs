impl Solution {
    pub fn largest_palindrome(n: i32) -> i32 {
        if n == 1 {
            return 9;
        }

        let max = (10_i64.pow(n as u32) - 1) as i64;
        let min = (10_i64.pow(n as u32 - 1)) as i64;

        for i in (1..).map(|x| max - x).take_while(|&x| x >= min) {
            let mut palindrome = i.to_string();
            palindrome.push_str(&i.to_string().chars().rev().collect::<String>());
            let palindrome_num = palindrome.parse::<i64>().unwrap();

            for j in (1..).map(|x| max).take_while(|&x| x * x >= palindrome_num) {
                if palindrome_num % j == 0 && palindrome_num / j >= min && palindrome_num / j <= max {
                    return (palindrome_num % 1337) as i32;
                }
            }
        }

        0
    }
}
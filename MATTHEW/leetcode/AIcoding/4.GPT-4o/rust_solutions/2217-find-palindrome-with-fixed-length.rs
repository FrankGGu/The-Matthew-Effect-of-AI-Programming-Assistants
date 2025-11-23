pub fn palindrome_of_fixed_length(n: i32, k: i32) -> Vec<i32> {
    let mut result = Vec::new();
    let half_length = (k + 1) / 2;
    let start = 10i32.pow(half_length - 1);
    let end = 10i32.pow(half_length);

    for i in start..end {
        let mut palindrome = i.to_string();
        if k % 2 == 0 {
            palindrome += &palindrome.chars().rev().collect::<String>();
        } else {
            palindrome += &palindrome.chars().rev().skip(1).collect::<String>();
        }
        let pal_num = palindrome.parse::<i32>().unwrap();
        if pal_num >= 10i32.pow(n - 1) && pal_num < 10i32.pow(n) {
            result.push(pal_num);
        }
    }

    result
}
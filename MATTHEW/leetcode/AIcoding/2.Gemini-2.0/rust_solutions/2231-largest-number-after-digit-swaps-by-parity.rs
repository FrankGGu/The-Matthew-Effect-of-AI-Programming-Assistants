impl Solution {
    pub fn largest_number_after_digit_swaps(num: i32) -> i32 {
        let mut s = num.to_string().chars().collect::<Vec<_>>();
        let n = s.len();

        let mut odds = Vec::new();
        let mut evens = Vec::new();

        for &c in &s {
            let digit = c.to_digit(10).unwrap() as i32;
            if digit % 2 == 0 {
                evens.push(digit);
            } else {
                odds.push(digit);
            }
        }

        odds.sort_by(|a, b| b.cmp(a));
        evens.sort_by(|a, b| b.cmp(a));

        let mut odd_idx = 0;
        let mut even_idx = 0;

        for i in 0..n {
            let digit = s[i].to_digit(10).unwrap() as i32;
            if digit % 2 == 0 {
                s[i] = char::from_digit(evens[even_idx] as u32, 10).unwrap();
                even_idx += 1;
            } else {
                s[i] = char::from_digit(odds[odd_idx] as u32, 10).unwrap();
                odd_idx += 1;
            }
        }

        s.iter().collect::<String>().parse::<i32>().unwrap()
    }
}
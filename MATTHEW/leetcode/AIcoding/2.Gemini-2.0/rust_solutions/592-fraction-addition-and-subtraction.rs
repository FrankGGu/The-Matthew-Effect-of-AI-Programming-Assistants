fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a.abs()
    } else {
        gcd(b, a % b)
    }
}

fn lcm(a: i32, b: i32) -> i32 {
    (a.abs() * b.abs()) / gcd(a, b)
}

impl Solution {
    pub fn fraction_addition(expression: String) -> String {
        let mut num = 0;
        let mut den = 1;
        let mut i = 0;
        while i < expression.len() {
            let sign = if i == 0 || expression.chars().nth(i).unwrap() == '+' {
                1
            } else {
                -1
            };
            i += 1;
            let mut j = i;
            while j < expression.len() && expression.chars().nth(j).unwrap().is_digit(10) {
                j += 1;
            }
            let num2 = expression[i..j].parse::<i32>().unwrap();
            i = j + 1;
            j = i;
            while j < expression.len() && expression.chars().nth(j).unwrap().is_digit(10) {
                j += 1;
            }
            let den2 = expression[i..j].parse::<i32>().unwrap();
            i = j;
            let new_den = lcm(den, den2);
            let new_num = num * (new_den / den) + sign * num2 * (new_den / den2);
            num = new_num;
            den = new_den;
            let common = gcd(num, den);
            num /= common;
            den /= common;
        }
        format!("{}/{}", num, den)
    }
}
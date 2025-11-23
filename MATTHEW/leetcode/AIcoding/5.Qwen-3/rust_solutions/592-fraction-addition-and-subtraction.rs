impl Solution {

use std::ops::Add;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct Fraction {
    numerator: i32,
    denominator: i32,
}

impl Fraction {
    fn new(numerator: i32, denominator: i32) -> Self {
        let gcd = Self::gcd(numerator.abs(), denominator.abs());
        let numerator = numerator / gcd;
        let denominator = denominator / gcd;
        if denominator < 0 {
            Fraction {
                numerator: -numerator,
                denominator: -denominator,
            }
        } else {
            Fraction { numerator, denominator }
        }
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    fn add(self, other: Self) -> Self {
        let lcm = self.denominator * other.denominator / Self::gcd(self.denominator, other.denominator);
        let left = self.numerator * (lcm / self.denominator);
        let right = other.numerator * (lcm / other.denominator);
        Fraction::new(left + right, lcm)
    }
}

fn add_fractions(expression: String) -> String {
    let mut tokens = Vec::new();
    let mut current_token = String::new();
    for c in expression.chars() {
        if c == '+' || c == '-' {
            tokens.push(current_token);
            current_token = String::new();
            current_token.push(c);
        } else {
            current_token.push(c);
        }
    }
    tokens.push(current_token);

    let mut result = Fraction::new(0, 1);
    for token in tokens {
        let parts: Vec<&str> = token.split('/').collect();
        let numerator = parts[0].parse::<i32>().unwrap();
        let denominator = parts[1].parse::<i32>().unwrap();
        let fraction = Fraction::new(numerator, denominator);
        result = result.add(fraction);
    }

    format!("{}/{}", result.numerator, result.denominator)
}

pub fn fraction_addition_subtraction(expression: String) -> String {
    add_fractions(expression)
}
}
#[derive(Debug, PartialEq, Eq)]
pub enum NestedInteger {
    Int(i32),
    List(Vec<NestedInteger>),
}

struct Solution;

impl Solution {
    pub fn deserialize(s: String) -> NestedInteger {
        let mut chars = s.chars().peekable();
        Self::parse(&mut chars)
    }

    fn parse(chars: &mut std::iter::Peekable<std::str::Chars>) -> NestedInteger {
        match chars.peek() {
            Some('[') => {
                chars.next(); // consume '['
                let mut list = Vec::new();
                while chars.peek() != Some(&']') {
                    list.push(Self::parse(chars));
                    if chars.peek() == Some(&',') {
                        chars.next();
                    }
                }
                chars.next(); // consume ']'
                NestedInteger::List(list)
            }
            _ => {
                let mut num_str = String::new();
                let is_negative = chars.peek() == Some(&'-');
                if is_negative {
                    num_str.push(chars.next().unwrap());
                }
                while let Some(&c) = chars.peek() {
                    if c.is_digit(10) {
                        num_str.push(chars.next().unwrap());
                    } else {
                        break;
                    }
                }
                NestedInteger::Int(num_str.parse().unwrap())
            }
        }
    }
}
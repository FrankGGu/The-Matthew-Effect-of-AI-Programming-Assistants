#[derive(Debug, PartialEq, Eq)]
pub enum NestedInteger {
    Int(i32),
    List(Vec<NestedInteger>),
}

impl NestedInteger {
    pub fn new(value: i32) -> Self {
        NestedInteger::Int(value)
    }

    pub fn new_list(list: Vec<NestedInteger>) -> Self {
        NestedInteger::List(list)
    }

    pub fn is_integer(&self) -> bool {
        matches!(self, NestedInteger::Int(_))
    }

    pub fn get_integer(&self) -> Option<i32> {
        match self {
            NestedInteger::Int(i) => Some(*i),
            _ => None,
        }
    }

    pub fn set_integer(&mut self, value: i32) {
        *self = NestedInteger::Int(value);
    }

    pub fn add(&mut self, ni: NestedInteger) {
        if let NestedInteger::List(list) = self {
            list.push(ni);
        }
    }

    pub fn get_list(&self) -> Option<&Vec<NestedInteger>> {
        match self {
            NestedInteger::List(list) => Some(list),
            _ => None,
        }
    }
}

struct Solution;

impl Solution {
    pub fn deserialize(s: String) -> NestedInteger {
        let mut chars = s.chars().peekable();
        Self::parse_nested_integer(&mut chars)
    }

    fn parse_nested_integer(chars: &mut std::iter::Peekable<std::str::Chars>) -> NestedInteger {
        if chars.peek() == Some(&'[') {
            chars.next(); 
            let mut list = Vec::new();
            while chars.peek() != Some(&']') {
                if chars.peek() == Some(&',') {
                    chars.next();
                }
                if chars.peek() == Some(&']') {
                    break;
                }
                list.push(Self::parse_nested_integer(chars));
            }
            chars.next();
            NestedInteger::List(list)
        } else {
            let mut num_str = String::new();
            while let Some(&c) = chars.peek() {
                if c.is_ascii_digit() || c == '-' {
                    num_str.push(chars.next().unwrap());
                } else {
                    break;
                }
            }
            NestedInteger::Int(num_str.parse().unwrap())
        }
    }
}
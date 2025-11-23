impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub enum NestedInteger {
    Int(i32),
    List(Vec<NestedInteger>),
}

struct Solution;

impl Solution {
    pub fn deserialize(s: String) -> NestedInteger {
        if s.is_empty() {
            return NestedInteger::List(vec![]);
        }

        let mut stack = vec![];
        let mut current = None;
        let mut num = String::new();
        let mut sign = 1;

        for c in s.chars() {
            match c {
                '-' => sign = -1,
                '0'..='9' => num.push(c),
                ',' => {
                    if !num.is_empty() {
                        let n = num.parse::<i32>().unwrap() * sign;
                        num.clear();
                        sign = 1;
                        if let Some(ref mut list) = current {
                            list.push(NestedInteger::Int(n));
                        } else {
                            current = Some(vec![NestedInteger::Int(n)]);
                        }
                    }
                },
                '[' => {
                    stack.push(current);
                    current = Some(vec![]);
                },
                ']' => {
                    if !num.is_empty() {
                        let n = num.parse::<i32>().unwrap() * sign;
                        num.clear();
                        sign = 1;
                        if let Some(ref mut list) = current {
                            list.push(NestedInteger::Int(n));
                        } else {
                            current = Some(vec![NestedInteger::Int(n)]);
                        }
                    }
                    if let Some(prev) = stack.pop() {
                        if let Some(ref mut list) = current {
                            current = prev;
                            if let Some(ref mut prev_list) = current {
                                prev_list.push(NestedInteger::List(list.clone()));
                            }
                        }
                    }
                },
                _ => {}
            }
        }

        if !num.is_empty() {
            let n = num.parse::<i32>().unwrap() * sign;
            return NestedInteger::Int(n);
        }

        current.unwrap_or_else(|| NestedInteger::List(vec![]))
    }
}
}
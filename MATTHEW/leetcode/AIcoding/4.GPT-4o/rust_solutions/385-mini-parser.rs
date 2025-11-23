#[derive(Debug)]
pub struct NestedInteger {
    value: Option<i32>,
    list: Option<Vec<NestedInteger>>,
}

impl NestedInteger {
    fn new() -> Self {
        NestedInteger { value: None, list: Some(vec![]) }
    }

    fn new_integer(value: i32) -> Self {
        NestedInteger { value: Some(value), list: None }
    }

    fn add(&mut self, ni: NestedInteger) {
        if let Some(ref mut l) = self.list {
            l.push(ni);
        }
    }

    fn set_integer(&mut self, value: i32) {
        self.value = Some(value);
        self.list = None;
    }

    fn is_integer(&self) -> bool {
        self.value.is_some()
    }

    fn get_integer(&self) -> i32 {
        self.value.unwrap()
    }

    fn get_list(&self) -> Vec<NestedInteger> {
        self.list.clone().unwrap_or_else(|| vec![])
    }
}

pub fn deserialize(s: String) -> NestedInteger {
    let mut stack: Vec<NestedInteger> = Vec::new();
    let mut current = NestedInteger::new();
    let mut num = 0;
    let mut in_num = false;

    for c in s.chars() {
        match c {
            '[' => {
                stack.push(current);
                current = NestedInteger::new();
            }
            ']' => {
                if in_num {
                    current.add(NestedInteger::new_integer(num));
                    in_num = false;
                }
                let top = stack.pop().unwrap();
                top.add(current);
                current = top;
            }
            ',' => {
                if in_num {
                    current.add(NestedInteger::new_integer(num));
                    in_num = false;
                }
            }
            _ => {
                if let Some(digit) = c.to_digit(10) {
                    num = num * 10 + digit as i32;
                    in_num = true;
                }
            }
        }
    }

    current
}
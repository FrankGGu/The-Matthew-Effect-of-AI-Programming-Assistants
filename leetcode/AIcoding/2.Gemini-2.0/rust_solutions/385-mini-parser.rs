#[derive(Debug, PartialEq, Eq)]
pub enum NestedInteger {
    Int(i32),
    List(Vec<NestedInteger>)
}

impl NestedInteger {
    // Constructor initializes an empty nested list.
    #[inline]
    pub fn new() -> Self {
        NestedInteger::List(Vec::new())
    }

    // Constructor initializes a single integer.
    #[inline]
    pub fn new_int(value: i32) -> Self {
        NestedInteger::Int(value)
    }

    // Return if this NestedInteger holds a single integer or a nested list.
    #[inline]
    pub fn is_integer(&self) -> bool {
        match self {
            NestedInteger::Int(_) => true,
            NestedInteger::List(_) => false,
        }
    }

    // If this NestedInteger holds a single integer, return the integer value.
    // Returns an Option to handle the case where it is a list.
    #[inline]
    pub fn get_integer(&self) -> Option<i32> {
        match self {
            NestedInteger::Int(val) => Some(*val),
            NestedInteger::List(_) => None,
        }
    }

    // Set this NestedInteger to hold a single integer.
    #[inline]
    pub fn set_integer(&mut self, value: i32) {
        *self = NestedInteger::Int(value);
    }

    // If this NestedInteger holds a nested list, return the list as a vector.
    // Returns an Option to handle the case where it is a single integer.
    #[inline]
    pub fn get_list(&self) -> Option<&Vec<NestedInteger>> {
        match self {
            NestedInteger::Int(_) => None,
            NestedInteger::List(list) => Some(list),
        }
    }

    #[inline]
    pub fn get_list_mut(&mut self) -> Option<&mut Vec<NestedInteger>> {
        match self {
            NestedInteger::Int(_) => None,
            NestedInteger::List(list) => Some(list),
        }
    }

    // Set this NestedInteger to hold a nested list and adds a nested integer to it.
    #[inline]
    pub fn add(&mut self, ni: NestedInteger) {
        match self {
            NestedInteger::Int(_) => panic!("Cannot add to an integer"),
            NestedInteger::List(list) => list.push(ni),
        }
    }
}

struct Solution {}
impl Solution {
    pub fn deserialize(s: String) -> NestedInteger {
        let mut stack: Vec<NestedInteger> = Vec::new();
        let mut num = 0;
        let mut sign = 1;
        let mut i = 0;
        while i < s.len() {
            let c = s.chars().nth(i).unwrap();
            match c {
                '[' => {
                    stack.push(NestedInteger::new());
                    i += 1;
                }
                ']' => {
                    if num != 0 {
                        stack.last_mut().unwrap().add(NestedInteger::Int(sign * num));
                        num = 0;
                        sign = 1;
                    }
                    let ni = stack.pop().unwrap();
                    if !stack.is_empty() {
                        stack.last_mut().unwrap().add(ni);
                    } else {
                        return ni;
                    }
                    i += 1;
                }
                ',' => {
                    if num != 0 {
                        stack.last_mut().unwrap().add(NestedInteger::Int(sign * num));
                        num = 0;
                        sign = 1;
                    }
                    i += 1;
                }
                '-' => {
                    sign = -1;
                    i += 1;
                }
                _ => {
                    num = num * 10 + (c as i32 - '0' as i32);
                    i += 1;
                }
            }
        }
        if num != 0 {
            return NestedInteger::Int(sign * num);
        }
        stack.pop().unwrap()
    }
}
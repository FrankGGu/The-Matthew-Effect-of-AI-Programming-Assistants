#[derive(Debug, Clone)]
pub enum NestedInteger {
    Int(i32),
    List(Vec<NestedInteger>),
}

pub struct NestedIterator {
    stack: Vec<std::slice::Iter<NestedInteger>>,
    current: Option<i32>,
}

impl NestedIterator {
    pub fn new(nested_list: Vec<NestedInteger>) -> Self {
        let mut stack = Vec::new();
        stack.push(nested_list.iter());
        NestedIterator { stack, current: None }
    }

    fn next_int(&mut self) -> Option<i32> {
        while let Some(iter) = self.stack.last_mut() {
            if let Some(nested) = iter.next() {
                match nested {
                    NestedInteger::Int(value) => {
                        return Some(*value);
                    }
                    NestedInteger::List(list) => {
                        self.stack.push(list.iter());
                    }
                }
            } else {
                self.stack.pop();
            }
        }
        None
    }
}

impl Iterator for NestedIterator {
    type Item = i32;

    fn next(&mut self) -> Option<Self::Item> {
        self.next_int()
    }
}
#[derive(Debug, PartialEq, Eq, Clone)]
pub enum NestedInteger {
    Int(i32),
    List(Vec<NestedInteger>),
}

struct NestedIterator {
    stack: Vec<NestedInteger>,
}

impl NestedIterator {
    fn new(nested_list: Vec<NestedInteger>) -> Self {
        NestedIterator { stack: nested_list.into_iter().rev().collect() }
    }

    fn next(&mut self) -> i32 {
        match self.stack.pop() {
            Some(NestedInteger::Int(val)) => val,
            _ => panic!("No next element"),
        }
    }

    fn has_next(&mut self) -> bool {
        while let Some(top) = self.stack.last() {
            match top {
                NestedInteger::Int(_) => return true,
                NestedInteger::List(_) => {
                    let list = self.stack.pop().unwrap();
                    if let NestedInteger::List(l) = list {
                        for item in l.into_iter().rev() {
                            self.stack.push(item);
                        }
                    }
                }
            }
        }
        false
    }
}
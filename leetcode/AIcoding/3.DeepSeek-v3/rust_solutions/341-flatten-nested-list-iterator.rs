#[derive(Debug, PartialEq, Eq)]
pub enum NestedInteger {
    Int(i32),
    List(Vec<NestedInteger>)
}

struct NestedIterator {
    stack: Vec<NestedInteger>,
}

impl NestedIterator {
    fn new(nested_list: Vec<NestedInteger>) -> Self {
        let mut stack = Vec::new();
        for item in nested_list.into_iter().rev() {
            stack.push(item);
        }
        NestedIterator { stack }
    }

    fn next(&mut self) -> i32 {
        if let Some(NestedInteger::Int(val)) = self.stack.pop() {
            val
        } else {
            unreachable!()
        }
    }

    fn has_next(&mut self) -> bool {
        while let Some(top) = self.stack.last_mut() {
            match top {
                NestedInteger::Int(_) => return true,
                NestedInteger::List(list) => {
                    let mut nested_list = std::mem::replace(list, Vec::new());
                    self.stack.pop();
                    for item in nested_list.into_iter().rev() {
                        self.stack.push(item);
                    }
                }
            }
        }
        false
    }
}
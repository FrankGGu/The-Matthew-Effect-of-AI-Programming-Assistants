#[derive(Debug, PartialEq, Eq)]
pub enum NestedInteger {
    Int(i32),
    List(Vec<NestedInteger>),
}

struct NestedIterator {
    stack: Vec<NestedInteger>,
}

impl NestedIterator {
    fn new(nested_list: Vec<NestedInteger>) -> Self {
        let mut stack = Vec::new();
        stack.extend(nested_list.into_iter().rev());
        NestedIterator { stack }
    }

    fn has_next(&mut self) -> bool {
        while let Some(top) = self.stack.last() {
            match top {
                NestedInteger::Int(_) => {
                    return true;
                }
                NestedInteger::List(_) => {
                    if let Some(NestedInteger::List(mut list_items)) = self.stack.pop() {
                        list_items.reverse();
                        self.stack.extend(list_items);
                    }
                }
            }
        }
        false
    }

    fn next(&mut self) -> i32 {
        if let Some(NestedInteger::Int(val)) = self.stack.pop() {
            val
        } else {
            // This branch should ideally not be reached if has_next() is called correctly before next().
            // Panic or a default value would be necessary if not guaranteed by problem constraints.
            // LeetCode context implies valid calls.
            panic!("Called next() when no integer is available or has_next() was false.");
        }
    }
}
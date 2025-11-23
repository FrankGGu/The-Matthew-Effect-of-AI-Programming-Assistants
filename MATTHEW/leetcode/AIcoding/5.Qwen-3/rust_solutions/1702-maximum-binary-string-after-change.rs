impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub type Rc<T> = std::rc::Rc<T>;
pub type RefCell<T> = std::cell::RefCell<T>;

impl Solution {
    pub fn maximum_binary_string(s: String) -> String {
        let s: Vec<char> = s.chars().collect();
        let n = s.len();
        let mut q = VecDeque::new();
        let mut res = vec!['0'; n];

        for (i, &c) in s.iter().enumerate() {
            if c == '0' {
                q.push_back(i);
            }
        }

        if q.len() <= 1 {
            return s.into_iter().collect();
        }

        let mut prev = q[0];
        let mut count = 0;

        while let Some(i) = q.pop_front() {
            if i > prev + 1 {
                count += 1;
            }
            prev = i;
        }

        res[q[0]] = '1';
        for i in 1..q.len() {
            res[q[i]] = '1';
        }

        for i in 0..n {
            if res[i] == '0' {
                res[i] = '1';
                break;
            }
        }

        res.into_iter().collect()
    }
}
}
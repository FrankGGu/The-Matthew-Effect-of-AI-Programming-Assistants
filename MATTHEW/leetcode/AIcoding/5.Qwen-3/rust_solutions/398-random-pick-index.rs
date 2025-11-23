impl Solution {

use std::cmp::Ordering;
use std::collections::HashMap;
use std::iter;
use std::rc::Rc;
use std::cell::RefCell;

struct Solution {
    indices: HashMap<i32, Vec<usize>>,
}

impl Solution {
    fn new(nums: Vec<i32>) -> Self {
        let mut indices = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            indices.entry(num).or_insert_with(Vec::new).push(i);
        }
        Solution { indices }
    }

    fn pick(&self, target: i32) -> i32 {
        let vec = self.indices.get(&target).unwrap();
        let len = vec.len();
        let index = rand::random::<usize>() % len;
        vec[index] as i32
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_solution() {
        let nums = vec![1, 2, 3, 3, 4];
        let solution = Solution::new(nums);
        let result = solution.pick(3);
        assert!(result == 2 || result == 3);
    }
}
}
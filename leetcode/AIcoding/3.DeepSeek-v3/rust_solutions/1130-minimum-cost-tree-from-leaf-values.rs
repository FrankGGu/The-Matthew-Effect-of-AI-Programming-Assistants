impl Solution {
    pub fn mct_from_leaf_values(arr: Vec<i32>) -> i32 {
        let mut stack = vec![std::i32::MAX];
        let mut res = 0;
        for &num in arr.iter() {
            while stack.last().unwrap() <= &num {
                let mid = stack.pop().unwrap();
                res += mid * std::cmp::min(stack.last().unwrap(), &num);
            }
            stack.push(num);
        }
        while stack.len() > 2 {
            res += stack.pop().unwrap() * stack.last().unwrap();
        }
        res
    }
}
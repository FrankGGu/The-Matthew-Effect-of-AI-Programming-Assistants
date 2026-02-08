use std::collections::VecDeque;

impl Solution {
    pub fn second_greater_element(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut res = vec![-1; n];
        let mut s1: Vec<usize> = Vec::new();
        let mut s2: Vec<usize> = Vec::new();
        let mut temp: VecDeque<usize> = VecDeque::new();

        for i in 0..n {
            while !s2.is_empty() && nums[i] > nums[*s2.last().unwrap()] {
                res[s2.pop().unwrap()] = nums[i];
            }

            while !s1.is_empty() && nums[i] > nums[*s1.last().unwrap()] {
                temp.push_front(s1.pop().unwrap());
            }

            while !temp.is_empty() {
                s2.push(temp.pop_front().unwrap());
            }

            s1.push(i);
        }

        res
    }
}
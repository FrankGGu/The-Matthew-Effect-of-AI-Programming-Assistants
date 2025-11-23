use std::collections::BinaryHeap;

impl Solution {
    pub fn magic_tower(nums: Vec<i32>) -> i32 {
        let mut hp = 0;
        let mut heap = BinaryHeap::new();
        let mut res = 0;
        let mut damage = 0;

        for &num in nums.iter() {
            hp += num;
            if num < 0 {
                heap.push(-num);
            }
            while hp <= 0 && !heap.is_empty() {
                let max_neg = heap.pop().unwrap();
                hp += max_neg;
                damage += max_neg;
                res += 1;
            }
            if hp <= 0 {
                return -1;
            }
        }
        if hp >= damage {
            res
        } else {
            -1
        }
    }
}
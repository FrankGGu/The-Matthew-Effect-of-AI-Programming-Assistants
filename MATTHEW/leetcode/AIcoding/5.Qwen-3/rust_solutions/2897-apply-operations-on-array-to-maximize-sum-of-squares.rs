impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn maximum_sum_of_squares(self, nums: Vec<i32>, ops: Vec<Vec<i32>>) -> i32 {
        let mut num_set = HashSet::new();
        for &num in &nums {
            num_set.insert(num);
        }

        let mut max_sum = 0;
        for op in ops {
            let (x, y) = (op[0], op[1]);
            if num_set.contains(&x) {
                num_set.remove(&x);
                num_set.insert(y);
            }
        }

        for num in num_set {
            max_sum += num * num;
        }

        max_sum
    }
}
}
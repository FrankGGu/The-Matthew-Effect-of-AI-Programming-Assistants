impl Solution {
    pub fn max_satisfied(customers: Vec<i32>, grumpy: Vec<i32>, minutes: i32) -> i32 {
        let n = customers.len();
        let mut satisfied = 0;
        for i in 0..n {
            if grumpy[i] == 0 {
                satisfied += customers[i];
            }
        }

        let mut max_extra = 0;
        let mut current_extra = 0;
        for i in 0..minutes as usize {
            if grumpy[i] == 1 {
                current_extra += customers[i];
            }
        }
        max_extra = current_extra;

        for i in minutes as usize..n {
            if grumpy[i] == 1 {
                current_extra += customers[i];
            }
            if grumpy[i - minutes as usize] == 1 {
                current_extra -= customers[i - minutes as usize];
            }
            max_extra = max_extra.max(current_extra);
        }

        satisfied + max_extra
    }
}
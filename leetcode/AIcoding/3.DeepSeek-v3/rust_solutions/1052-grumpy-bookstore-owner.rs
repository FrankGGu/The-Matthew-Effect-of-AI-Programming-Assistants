impl Solution {
    pub fn max_satisfied(customers: Vec<i32>, grumpy: Vec<i32>, minutes: i32) -> i32 {
        let mut total_satisfied = 0;
        let mut max_extra = 0;
        let mut current_extra = 0;
        let minutes = minutes as usize;

        for i in 0..customers.len() {
            if grumpy[i] == 0 {
                total_satisfied += customers[i];
            } else {
                current_extra += customers[i];
            }

            if i >= minutes {
                if grumpy[i - minutes] == 1 {
                    current_extra -= customers[i - minutes];
                }
            }

            if current_extra > max_extra {
                max_extra = current_extra;
            }
        }

        total_satisfied + max_extra
    }
}
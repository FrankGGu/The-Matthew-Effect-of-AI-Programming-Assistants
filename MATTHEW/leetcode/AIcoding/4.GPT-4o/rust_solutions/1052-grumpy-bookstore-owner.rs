impl Solution {
    pub fn max_customers(customers: Vec<i32>, grumpy: Vec<i32>, X: i32) -> i32 {
        let n = customers.len();
        let mut total_customers = 0;
        let mut extra_customers = 0;

        for i in 0..n {
            total_customers += if grumpy[i] == 0 { customers[i] } else { 0 };
        }

        for i in 0..X as usize {
            if grumpy[i] == 1 {
                extra_customers += customers[i];
            }
        }

        let mut max_extra = extra_customers;

        for i in X as usize..n {
            if grumpy[i] == 1 {
                extra_customers += customers[i];
            }
            if grumpy[i - X as usize] == 1 {
                extra_customers -= customers[i - X as usize];
            }
            max_extra = max_extra.max(extra_customers);
        }

        total_customers + max_extra
    }
}
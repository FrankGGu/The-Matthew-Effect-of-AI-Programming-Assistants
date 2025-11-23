struct Solution;

impl Solution {
    pub fn max_maximize_customers(customers: Vec<i32>, grumpy: Vec<i32>, minutes: i32) -> i32 {
        let n = customers.len();
        let mut max_customers = 0;
        let mut current_customers = 0;
        let mut left = 0;

        for right in 0..n {
            if grumpy[right] == 0 {
                current_customers += customers[right];
            }

            while right - left + 1 > minutes as usize {
                if grumpy[left] == 0 {
                    current_customers -= customers[left];
                }
                left += 1;
            }

            max_customers = std::cmp::max(max_customers, current_customers);
        }

        max_customers
    }
}
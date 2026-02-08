impl Solution {
    pub fn max_sales(sales: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        if sales.len() < k {
            return 0;
        }

        let mut current_sum: i32 = sales[0..k].iter().sum();
        let mut max_sum = current_sum;

        for i in k..sales.len() {
            current_sum += sales[i] - sales[i - k];
            max_sum = max_sum.max(current_sum);
        }

        max_sum
    }
}
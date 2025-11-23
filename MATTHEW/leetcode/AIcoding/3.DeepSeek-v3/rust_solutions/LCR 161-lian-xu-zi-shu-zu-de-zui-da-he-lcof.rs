impl Solution {
    pub fn max_sales(sales: Vec<i32>) -> i32 {
        let mut max_current = sales[0];
        let mut max_global = sales[0];

        for &num in sales.iter().skip(1) {
            max_current = num.max(max_current + num);
            max_global = max_global.max(max_current);
        }

        max_global
    }
}
impl Solution {
    pub fn seasonal_sales_analysis(sales: Vec<i32>) -> Vec<f64> {
        let n = sales.len();
        let mut total_sales = vec![0.0; 4];
        let mut count = vec![0; 4];

        for i in 0..n {
            let season = i % 4;
            total_sales[season] += sales[i] as f64;
            count[season] += 1;
        }

        total_sales.iter()
            .zip(count.iter())
            .map(|(total, cnt)| total / *cnt as f64)
            .collect()
    }
}
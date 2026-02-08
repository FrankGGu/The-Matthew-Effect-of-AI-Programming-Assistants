pub fn max_sales_days(sales: Vec<i32>) -> i32 {
    let mut max_sales = 0;
    let mut current_sales = 0;

    for sale in sales {
        if sale > 0 {
            current_sales += 1;
            if current_sales > max_sales {
                max_sales = current_sales;
            }
        } else {
            current_sales = 0;
        }
    }

    max_sales
}
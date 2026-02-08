struct NumArray {
    prefix_products: Vec<i64>,
}

impl NumArray {
    fn new(nums: Vec<i32>) -> Self {
        let mut prefix_products = vec![1];
        let mut product = 1;
        for &num in &nums {
            product *= num as i64;
            prefix_products.push(product);
        }
        NumArray { prefix_products }
    }

    fn product_range(&self, left: i32, right: i32) -> i64 {
        self.prefix_products[right as usize + 1] / self.prefix_products[left as usize]
    }
}
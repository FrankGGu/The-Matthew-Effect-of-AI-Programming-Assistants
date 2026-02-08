impl Solution {
    pub fn stock_management(stock: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut right = stock.len() - 1;
        while left < right {
            let mid = left + (right - left) / 2;
            if stock[mid] < stock[right] {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        stock[left]
    }
}
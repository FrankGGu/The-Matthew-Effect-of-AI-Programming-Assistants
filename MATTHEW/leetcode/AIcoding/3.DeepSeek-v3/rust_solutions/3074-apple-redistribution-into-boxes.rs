impl Solution {
    pub fn minimum_boxes(apple: Vec<i32>, capacity: Vec<i32>) -> i32 {
        let sum: i32 = apple.iter().sum();
        let mut capacity = capacity;
        capacity.sort_by(|a, b| b.cmp(a));
        let mut total = 0;
        let mut count = 0;
        for &cap in capacity.iter() {
            total += cap;
            count += 1;
            if total >= sum {
                return count;
            }
        }
        count
    }
}
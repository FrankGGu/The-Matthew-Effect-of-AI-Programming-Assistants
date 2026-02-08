impl Solution {
    pub fn max_elements(arr: Vec<i32>, limit: i32) -> i32 {
        let mut arr = arr;
        arr.sort();
        let mut count = 0;
        let mut total = 0;

        for &num in &arr {
            if total + num <= limit {
                total += num;
                count += 1;
            } else {
                break;
            }
        }

        count
    }
}
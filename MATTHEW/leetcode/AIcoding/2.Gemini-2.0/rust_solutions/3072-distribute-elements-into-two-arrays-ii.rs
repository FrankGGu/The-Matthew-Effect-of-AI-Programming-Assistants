impl Solution {
    pub fn distribute_elements(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut arr1: Vec<i32> = Vec::new();
        let mut arr2: Vec<i32> = Vec::new();
        let mut res: Vec<i32> = Vec::new();

        for &num in &nums {
            if arr1.len() < k as usize || (arr2.len() > 0 && num > *arr2.last().unwrap()) {
                arr1.push(num);
                res.push(1);
            } else {
                arr2.push(num);
                res.push(2);
            }
        }

        res
    }
}
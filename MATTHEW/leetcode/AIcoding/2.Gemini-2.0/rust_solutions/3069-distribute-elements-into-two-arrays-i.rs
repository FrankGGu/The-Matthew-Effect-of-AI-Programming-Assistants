impl Solution {
    pub fn distribute_elements(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut arr1: Vec<i32> = Vec::new();
        let mut arr2: Vec<i32> = Vec::new();
        let mut ans: Vec<i32> = Vec::new();

        for &num in &nums {
            if arr1.is_empty() || num >= *arr1.last().unwrap() {
                arr1.push(num);
                ans.push(num);
            } else {
                arr2.push(num);
                ans.push(num);
            }
        }

        ans
    }
}
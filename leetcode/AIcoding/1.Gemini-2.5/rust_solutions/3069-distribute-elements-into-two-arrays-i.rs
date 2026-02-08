impl Solution {
    pub fn distribute_elements(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut arr1: Vec<i32> = Vec::new();
        let mut arr2: Vec<i32> = Vec::new();

        arr1.push(nums[0]);
        arr2.push(nums[1]);

        for i in 2..n {
            if *arr1.last().unwrap() > *arr2.last().unwrap() {
                arr1.push(nums[i]);
            } else {
                arr2.push(nums[i]);
            }
        }

        arr1.extend(arr2);
        arr1
    }
}
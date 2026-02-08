impl Solution {
    pub fn result_array(nums: Vec<i32>) -> Vec<i32> {
        let mut arr1 = Vec::new();
        let mut arr2 = Vec::new();

        if nums.is_empty() {
            return vec![];
        }

        arr1.push(nums[0]);
        if nums.len() > 1 {
            arr2.push(nums[1]);
        }

        for i in 2..nums.len() {
            if arr1.last().unwrap() > arr2.last().unwrap() {
                arr1.push(nums[i]);
            } else {
                arr2.push(nums[i]);
            }
        }

        arr1.extend(arr2);
        arr1
    }
}
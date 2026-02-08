impl Solution {
    pub fn get_final_array_after_k_multiplication(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut arr = nums;
        for query in queries {
            let start = query[0] as usize;
            let end = query[1] as usize;
            let val = query[2];
            for i in start..=end {
                arr[i] *= val;
            }
        }
        arr
    }
}
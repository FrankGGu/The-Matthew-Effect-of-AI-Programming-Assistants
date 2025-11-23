impl Solution {
    pub fn get_final_array(mut nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        for query in queries {
            let index = query[0] as usize;
            let value = query[1];
            nums[index] *= value;
        }
        nums
    }
}
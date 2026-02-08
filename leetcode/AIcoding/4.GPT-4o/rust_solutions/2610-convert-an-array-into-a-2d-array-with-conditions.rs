impl Solution {
    pub fn convert_to_2d_array(arr: Vec<i32>, r: i32, c: i32) -> Vec<Vec<i32>> {
        if arr.len() != (r * c) as usize {
            return vec![];
        }
        let mut result = Vec::new();
        for i in 0..r {
            let start = (i * c) as usize;
            let end = start + c as usize;
            result.push(arr[start..end].to_vec());
        }
        result
    }
}
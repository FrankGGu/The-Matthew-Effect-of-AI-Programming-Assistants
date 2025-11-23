impl Solution {
    pub fn get_subarray_beauty(nums: Vec<i32>, k: i32, x: i32) -> Vec<i32> {
        let n = nums.len();
        let k = k as usize;
        let mut result = Vec::new();

        for i in 0..=n - k {
            let mut subarray = nums[i..i + k].to_vec();
            subarray.sort();
            let beauty = if subarray[0] < 0 {
                if x as usize <= subarray.len() {
                    if subarray[(x as usize) - 1] < 0 {
                        subarray[(x as usize) - 1]
                    } else {
                        0
                    }
                } else {
                    0
                }
            } else {
                0
            };
            result.push(beauty);
        }

        result
    }
}
impl Solution {
    pub fn can_be_increasing(nums: Vec<i32>) -> bool {
        let n = nums.len();
        for i in 0..n {
            let mut temp = Vec::new();
            for j in 0..n {
                if i != j {
                    temp.push(nums[j]);
                }
            }
            let mut increasing = true;
            for k in 1..temp.len() {
                if temp[k] <= temp[k - 1] {
                    increasing = false;
                    break;
                }
            }
            if increasing {
                return true;
            }
        }
        false
    }
}
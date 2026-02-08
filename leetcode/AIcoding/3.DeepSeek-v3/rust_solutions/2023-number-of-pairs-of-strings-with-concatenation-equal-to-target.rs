impl Solution {
    pub fn num_of_pairs(nums: Vec<String>, target: String) -> i32 {
        let mut count = 0;
        let n = nums.len();
        for i in 0..n {
            for j in 0..n {
                if i != j && nums[i].len() + nums[j].len() == target.len() {
                    let concat = format!("{}{}", nums[i], nums[j]);
                    if concat == target {
                        count += 1;
                    }
                }
            }
        }
        count
    }
}
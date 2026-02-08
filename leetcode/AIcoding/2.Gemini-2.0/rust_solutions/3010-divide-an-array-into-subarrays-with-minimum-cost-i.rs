impl Solution {
    pub fn minimum_cost(nums: Vec<i32>) -> i32 {
        let mut arr = vec![nums[1], nums[2]];
        for i in 3..nums.len() {
            arr.push(nums[i]);
        }
        arr.sort();

        nums[0] + arr[0] + arr[1]
    }
}
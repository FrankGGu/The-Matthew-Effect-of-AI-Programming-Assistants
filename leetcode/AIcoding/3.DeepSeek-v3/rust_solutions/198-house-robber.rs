impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        let (mut prev, mut curr) = (0, 0);
        for num in nums {
            let temp = curr;
            curr = curr.max(prev + num);
            prev = temp;
        }
        curr
    }
}
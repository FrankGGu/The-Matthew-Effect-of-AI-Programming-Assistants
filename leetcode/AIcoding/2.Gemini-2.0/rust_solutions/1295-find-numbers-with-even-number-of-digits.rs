impl Solution {
    pub fn find_numbers(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        for num in nums {
            let digits = num.to_string().len();
            if digits % 2 == 0 {
                count += 1;
            }
        }
        count
    }
}
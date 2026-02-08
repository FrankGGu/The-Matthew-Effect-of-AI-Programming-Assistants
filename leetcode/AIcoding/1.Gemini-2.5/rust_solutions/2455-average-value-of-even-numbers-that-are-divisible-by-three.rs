impl Solution {
    pub fn average_value(nums: Vec<i32>) -> i32 {
        let mut sum: i32 = 0;
        let mut count: i32 = 0;

        for num in nums {
            if num % 2 == 0 && num % 3 == 0 {
                sum += num;
                count += 1;
            }
        }

        if count == 0 {
            0
        } else {
            sum / count
        }
    }
}
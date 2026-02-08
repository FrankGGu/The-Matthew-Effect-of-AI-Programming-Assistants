impl Solution {
    pub fn find_numbers(nums: Vec<i32>) -> i32 {
        nums.iter().filter(|&&num| {
            let mut n = num;
            let mut digits = 0;
            while n != 0 {
                n /= 10;
                digits += 1;
            }
            digits % 2 == 0
        }).count() as i32
    }
}
impl Solution {
    pub fn repair_cars(nums: Vec<i32>, cars: i32) -> i64 {
        let (mut left, mut right) = (1, *nums.iter().max().unwrap() as i64 * cars as i64);
        while left < right {
            let mid = (left + right) / 2;
            let total_cars: i64 = nums.iter().map(|&x| mid / x as i64).sum();
            if total_cars >= cars as i64 {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        left
    }
}
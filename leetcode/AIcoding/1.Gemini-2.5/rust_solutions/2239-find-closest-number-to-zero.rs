impl Solution {
    pub fn find_closest_number(nums: Vec<i32>) -> i32 {
        let mut closest_num = nums[0];

        for &num in nums.iter().skip(1) {
            let abs_num = num.abs();
            let abs_closest = closest_num.abs();

            if abs_num < abs_closest {
                closest_num = num;
            } else if abs_num == abs_closest {
                closest_num = closest_num.max(num);
            }
        }

        closest_num
    }
}
impl Solution {
    pub fn dominant_index(nums: Vec<i32>) -> i32 {
        let mut max = -1;
        let mut second_max = -1;
        let mut index = -1;

        for (i, &num) in nums.iter().enumerate() {
            if num > max {
                second_max = max;
                max = num;
                index = i as i32;
            } else if num > second_max {
                second_max = num;
            }
        }

        if max >= 2 * second_max {
            index
        } else {
            -1
        }
    }
}
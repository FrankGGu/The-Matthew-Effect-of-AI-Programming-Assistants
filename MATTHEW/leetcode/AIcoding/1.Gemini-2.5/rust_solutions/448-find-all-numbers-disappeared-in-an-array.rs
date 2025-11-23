impl Solution {
    pub fn find_disappeared_numbers(mut nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();

        for i in 0..n {
            let num = nums[i].abs();
            let index_to_mark = (num - 1) as usize;

            if nums[index_to_mark] > 0 {
                nums[index_to_mark] = -nums[index_to_mark];
            }
        }

        let mut result = Vec::new();
        for i in 0..n {
            if nums[i] > 0 {
                result.push((i + 1) as i32);
            }
        }

        result
    }
}
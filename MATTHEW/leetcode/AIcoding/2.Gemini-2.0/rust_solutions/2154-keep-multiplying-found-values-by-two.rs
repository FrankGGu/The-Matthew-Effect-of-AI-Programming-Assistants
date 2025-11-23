impl Solution {
    pub fn find_final_value(nums: Vec<i32>, original: i32) -> i32 {
        let mut val = original;
        let mut found = true;

        while found {
            found = false;
            for &num in &nums {
                if num == val {
                    val *= 2;
                    found = true;
                    break;
                }
            }
        }

        val
    }
}
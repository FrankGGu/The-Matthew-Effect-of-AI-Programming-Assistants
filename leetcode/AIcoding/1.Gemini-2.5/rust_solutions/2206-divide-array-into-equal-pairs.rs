impl Solution {
    pub fn divide_array(nums: Vec<i32>) -> bool {
        let mut counts = [0; 1001];
        for num in nums {
            counts[num as usize] += 1;
        }

        for count in counts.iter() {
            if count % 2 != 0 {
                return false;
            }
        }

        true
    }
}
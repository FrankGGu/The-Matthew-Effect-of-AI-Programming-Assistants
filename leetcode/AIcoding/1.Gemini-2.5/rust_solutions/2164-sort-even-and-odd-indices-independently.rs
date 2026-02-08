impl Solution {
    pub fn sort_even_odd(mut nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        if n <= 1 {
            return nums;
        }

        let mut even_elements = Vec::new();
        let mut odd_elements = Vec::new();

        for i in 0..n {
            if i % 2 == 0 {
                even_elements.push(nums[i]);
            } else {
                odd_elements.push(nums[i]);
            }
        }

        even_elements.sort();
        odd_elements.sort_by(|a, b| b.cmp(a));

        let mut result = vec![0; n];
        let mut even_idx = 0;
        let mut odd_idx = 0;

        for i in 0..n {
            if i % 2 == 0 {
                result[i] = even_elements[even_idx];
                even_idx += 1;
            } else {
                result[i] = odd_elements[odd_idx];
                odd_idx += 1;
            }
        }

        result
    }
}
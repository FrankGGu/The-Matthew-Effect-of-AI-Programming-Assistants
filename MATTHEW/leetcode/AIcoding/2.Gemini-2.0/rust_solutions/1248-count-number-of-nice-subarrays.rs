impl Solution {
    pub fn number_of_nice_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut odd_indices = vec![-1];
        for (i, &num) in nums.iter().enumerate() {
            if num % 2 != 0 {
                odd_indices.push(i as i32);
            }
        }
        odd_indices.push(nums.len() as i32);

        let mut count = 0;
        for i in 1..(odd_indices.len() - 1) {
            if (i as i32 + k - 1) < (odd_indices.len() - 1) as i32 {
                let left = odd_indices[i as usize] - odd_indices[i as usize - 1] ;
                let right = odd_indices[(i as i32 + k) as usize] - odd_indices[(i as i32 + k - 1) as usize];
                count += left * right;
            }
        }

        count
    }
}
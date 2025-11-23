impl Solution {
    pub fn array_nesting(nums: Vec<i32>) -> i32 {
        let mut visited = vec![false; nums.len()];
        let mut max_size = 0;

        for i in 0..nums.len() {
            if !visited[i] {
                let mut size = 0;
                let mut j = i;

                while !visited[j] {
                    visited[j] = true;
                    j = nums[j] as usize;
                    size += 1;
                }
                max_size = max_size.max(size);
            }
        }
        max_size
    }
}
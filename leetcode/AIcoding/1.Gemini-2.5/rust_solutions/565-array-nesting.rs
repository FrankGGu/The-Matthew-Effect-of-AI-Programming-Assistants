impl Solution {
    pub fn array_nesting(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut visited = vec![false; n];
        let mut max_len = 0;

        for i in 0..n {
            if !visited[i] {
                let mut current_len = 0;
                let mut current_node = i;
                while !visited[current_node] {
                    visited[current_node] = true;
                    current_len += 1;
                    current_node = nums[current_node] as usize;
                }
                max_len = max_len.max(current_len);
            }
        }
        max_len
    }
}
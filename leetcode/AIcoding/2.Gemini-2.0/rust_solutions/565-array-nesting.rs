impl Solution {
    pub fn array_nesting(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut visited = vec![false; n];
        let mut max_len = 0;

        for i in 0..n {
            if !visited[i] {
                let mut len = 0;
                let mut current = i;
                while !visited[current] {
                    visited[current] = true;
                    current = nums[current] as usize;
                    len += 1;
                }
                max_len = max_len.max(len);
            }
        }

        max_len
    }
}
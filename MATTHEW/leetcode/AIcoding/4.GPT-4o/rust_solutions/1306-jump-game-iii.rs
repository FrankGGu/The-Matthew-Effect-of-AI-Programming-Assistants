impl Solution {
    pub fn can_reach(arr: Vec<i32>, start: i32) -> bool {
        let n = arr.len();
        let mut visited = vec![false; n];
        let mut stack = vec![start as usize];

        while let Some(pos) = stack.pop() {
            if pos >= n || visited[pos] {
                continue;
            }
            visited[pos] = true;
            if arr[pos] == 0 {
                return true;
            }
            let jump_forward = pos + arr[pos] as usize;
            let jump_backward = pos as isize - arr[pos] as isize;
            if jump_forward < n {
                stack.push(jump_forward);
            }
            if jump_backward >= 0 {
                stack.push(jump_backward as usize);
            }
        }

        false
    }
}
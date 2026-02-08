impl Solution {
    pub fn can_reach(arr: Vec<i32>, start: i32) -> bool {
        let n = arr.len();
        let mut visited = vec![false; n];
        let mut stack = vec![start as usize];

        while let Some(pos) = stack.pop() {
            if pos < 0 || pos >= n || visited[pos] {
                continue;
            }
            if arr[pos] == 0 {
                return true;
            }
            visited[pos] = true;
            let jump = arr[pos] as usize;
            if pos + jump < n {
                stack.push(pos + jump);
            }
            if pos >= jump {
                stack.push(pos - jump);
            }
        }

        false
    }
}
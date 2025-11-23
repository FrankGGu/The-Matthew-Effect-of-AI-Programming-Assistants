impl Solution {
    pub fn can_reach(arr: Vec<i32>, start: i32) -> bool {
        let n = arr.len();
        let mut visited = vec![false; n];
        let mut stack = vec![start as usize];

        while let Some(pos) = stack.pop() {
            if arr[pos] == 0 {
                return true;
            }
            visited[pos] = true;

            let left = pos as i32 - arr[pos];
            if left >= 0 && !visited[left as usize] {
                stack.push(left as usize);
            }

            let right = pos as i32 + arr[pos];
            if right < n as i32 && !visited[right as usize] {
                stack.push(right as usize);
            }
        }

        false
    }
}
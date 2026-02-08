impl Solution {
    pub fn max_candies(boxes: Vec<i32>, keys: Vec<Vec<i32>>, locked: Vec<i32>, initial_boxes: Vec<i32>) -> i32 {
        let n = boxes.len();
        let mut has_box = vec![false; n];
        let mut has_key = vec![false; n];
        let mut is_locked = vec![false; n];

        for i in 0..n {
            is_locked[i] = locked[i] == 1;
        }

        for &box_idx in &initial_boxes {
            has_box[box_idx as usize] = true;
        }

        let mut q = Vec::new();
        for i in 0..n {
            if has_box[i] && !is_locked[i] {
                q.push(i);
            }
        }

        let mut ans = 0;
        let mut visited = vec![false; n];

        while !q.is_empty() {
            let u = q.remove(0);
            if visited[u] {
                continue;
            }
            visited[u] = true;
            ans += boxes[u];

            for &key_idx in &keys[u] {
                has_key[key_idx as usize] = true;
                if is_locked[key_idx as usize] {
                    is_locked[key_idx as usize] = false;
                    if has_box[key_idx as usize] {
                        q.push(key_idx as usize);
                    }
                }
            }

            for v in 0..n {
                if has_box[v] && !visited[v] && !is_locked[v] {
                    q.push(v);
                }
            }
        }

        ans
    }
}
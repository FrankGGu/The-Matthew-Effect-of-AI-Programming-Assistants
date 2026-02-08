impl Solution {
    pub fn wardrobe_finish(m: i32, n: i32, cnt: i32) -> i32 {
        let mut visited = vec![vec![false; n as usize]; m as usize];
        let mut queue = std::collections::VecDeque::new();
        queue.push_back((0, 0));
        visited[0][0] = true;
        let mut res = 0;

        while let Some((i, j)) = queue.pop_front() {
            if Self::digit_sum(i) + Self::digit_sum(j) > cnt {
                continue;
            }
            res += 1;

            for (di, dj) in [(0, 1), (1, 0)] {
                let ni = i + di;
                let nj = j + dj;
                if ni < m && nj < n && !visited[ni as usize][nj as usize] {
                    visited[ni as usize][nj as usize] = true;
                    queue.push_back((ni, nj));
                }
            }
        }

        res
    }

    fn digit_sum(mut x: i32) -> i32 {
        let mut sum = 0;
        while x > 0 {
            sum += x % 10;
            x /= 10;
        }
        sum
    }
}
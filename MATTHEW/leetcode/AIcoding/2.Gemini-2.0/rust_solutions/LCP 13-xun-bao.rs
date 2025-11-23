use std::collections::VecDeque;

impl Solution {
    pub fn minimal_steps(maze: Vec<String>) -> i32 {
        let m = maze.len();
        let n = maze[0].len();
        let mut start = (0, 0);
        let mut target = (0, 0);
        let mut stones = Vec::new();
        for i in 0..m {
            for j in 0..n {
                let c = maze[i].chars().nth(j).unwrap();
                if c == 'S' {
                    start = (i, j);
                } else if c == 'T' {
                    target = (i, j);
                } else if c == 'O' {
                    stones.push((i, j));
                }
            }
        }

        let k = stones.len();
        let mut dist = vec![vec![vec![i32::MAX; k + 2]; k + 2]; k + 2];

        let mut points = vec![start];
        points.extend(stones.clone());
        points.push(target);

        for i in 0..=k + 1 {
            for j in i + 1..=k + 1 {
                let d = bfs(&maze, points[i], points[j]);
                if d == -1 {
                    return -1;
                }
                dist[i][j] = d;
                dist[j][i] = d;
            }
        }

        if k == 0 {
            return dist[0][k + 1];
        }

        let mut dp = vec![vec![i32::MAX; 1 << k]; k + 1];
        for i in 1..=k {
            dp[i][1 << (i - 1)] = dist[0][i];
        }

        for mask in 1..(1 << k) {
            for i in 1..=k {
                if (mask & (1 << (i - 1))) != 0 {
                    for j in 1..=k {
                        if (mask & (1 << (j - 1))) == 0 {
                            dp[j][mask | (1 << (j - 1))] = dp[j][mask | (1 << (j - 1))].min(dp[i][mask] + dist[i][j]);
                        }
                    }
                }
            }
        }

        let mut ans = i32::MAX;
        for i in 1..=k {
            ans = ans.min(dp[i][(1 << k) - 1] + dist[i][k + 1]);
        }

        if ans == i32::MAX {
            -1
        } else {
            ans
        }
    }
}

fn bfs(maze: &Vec<String>, start: (usize, usize), target: (usize, usize)) -> i32 {
    let m = maze.len();
    let n = maze[0].len();
    let mut visited = vec![vec![false; n]; m];
    let mut queue = VecDeque::new();
    queue.push_back((start.0, start.1, 0));
    visited[start.0][start.1] = true;

    let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];

    while let Some((x, y, steps)) = queue.pop_front() {
        if x == target.0 && y == target.1 {
            return steps;
        }

        for (dx, dy) in directions {
            let nx = x as i32 + dx;
            let ny = y as i32 + dy;

            if nx >= 0 && nx < m as i32 && ny >= 0 && ny < n as i32 {
                let nxu = nx as usize;
                let nyu = ny as usize;
                if maze[nxu].chars().nth(nyu).unwrap() != '#' && !visited[nxu][nyu] {
                    visited[nxu][nyu] = true;
                    queue.push_back((nxu, nyu, steps + 1));
                }
            }
        }
    }

    -1
}

struct Solution;
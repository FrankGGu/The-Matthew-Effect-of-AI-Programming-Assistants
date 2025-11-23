struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            size: vec![1; n],
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            self.parent[i] = self.find(self.parent[i]);
            self.parent[i]
        }
    }

    fn union(&mut self, i: usize, j: usize) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);
        if root_i != root_j {
            if self.size[root_i] < self.size[root_j] {
                self.parent[root_i] = root_j;
                self.size[root_j] += self.size[root_i];
            } else {
                self.parent[root_j] = root_i;
                self.size[root_i] += self.size[root_j];
            }
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn is_reachable(x1: i32, y1: i32, x2: i32, y2: i32, circles: Vec<Vec<i32>>) -> bool {
        let x_min = x1.min(x2) as i64;
        let x_max = x1.max(x2) as i64;
        let y_min = y1.min(y2) as i64;
        let y_max = y1.max(y2) as i64;

        let n = circles.len();
        // N circles + 4 virtual walls (left, right, bottom, top)
        // Indices: 0..N-1 for circles
        // N for left_wall
        // N+1 for right_wall
        // N+2 for bottom_wall
        // N+3 for top_wall
        let mut dsu = DSU::new(n + 4);

        for i in 0..n {
            let cx = circles[i][0] as i64;
            let cy = circles[i][1] as i64;
            let r = circles[i][2] as i64;

            // Check connection to walls
            if cx - r <= x_min { // Touches or crosses left wall
                dsu.union(i, n); // Union with left_wall
            }
            if cx + r >= x_max { // Touches or crosses right wall
                dsu.union(i, n + 1); // Union with right_wall
            }
            if cy - r <= y_min { // Touches or crosses bottom wall
                dsu.union(i, n + 2); // Union with bottom_wall
            }
            if cy + r >= y_max { // Touches or crosses top wall
                dsu.union(i, n + 3); // Union with top_wall
            }

            // Check connection to other circles
            for j in (i + 1)..n {
                let cx2 = circles[j][0] as i64;
                let cy2 = circles[j][1] as i64;
                let r2 = circles[j][2] as i64;

                let dx = cx - cx2;
                let dy = cy - cy2;
                let dist_sq = dx * dx + dy * dy;
                let r_sum = r + r2;
                let r_sum_sq = r_sum * r_sum;

                if dist_sq <= r_sum_sq {
                    dsu.union(i, j);
                }
            }
        }

        // Check if left_wall is connected to right_wall
        let left_right_blocked = dsu.find(n) == dsu.find(n + 1);
        // Check if bottom_wall is connected to top_wall
        let bottom_top_blocked = dsu.find(n + 2) == dsu.find(n + 3);

        // The corner is reachable if and only if there is NO chain of circles
        // connecting the left wall to the right wall, AND
        // NO chain of circles connecting the bottom wall to the top wall.
        // If either of these conditions is true, the path is blocked.
        !(left_right_blocked || bottom_top_blocked)
    }
}
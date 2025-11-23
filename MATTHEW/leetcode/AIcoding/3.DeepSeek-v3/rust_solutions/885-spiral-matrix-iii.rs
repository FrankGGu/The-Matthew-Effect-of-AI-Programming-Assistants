impl Solution {
    pub fn spiral_matrix_iii(r: i32, c: i32, r0: i32, c0: i32) -> Vec<Vec<i32>> {
        let mut res = vec![vec![r0, c0]];
        let mut step = 1;
        let (mut x, mut y) = (r0, c0);
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut dir = 0;

        while res.len() < (r * c) as usize {
            for _ in 0..2 {
                let (dx, dy) = directions[dir % 4];
                for _ in 0..step {
                    x += dx;
                    y += dy;
                    if x >= 0 && x < r && y >= 0 && y < c {
                        res.push(vec![x, y]);
                    }
                }
                dir += 1;
            }
            step += 1;
        }
        res
    }
}
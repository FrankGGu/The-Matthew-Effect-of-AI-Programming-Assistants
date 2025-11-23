pub fn regions_by_slashes(grid: Vec<String>) -> i32 {
    use std::collections::HashSet;

    let n = grid.len();
    let mut parent = vec![vec![0; n * 3]; n * 3];
    let mut rank = vec![0; n * 3 * n * 3];

    fn find(parent: &mut Vec<Vec<usize>>, x: usize) -> usize {
        if parent[x][0] != x {
            parent[x][0] = find(parent, parent[x][0]);
        }
        parent[x][0]
    }

    fn union(parent: &mut Vec<Vec<usize>>, rank: &mut Vec<usize>, x: usize, y: usize) {
        let root_x = find(parent, x);
        let root_y = find(parent, y);
        if root_x != root_y {
            if rank[root_x] > rank[root_y] {
                parent[root_y][0] = root_x;
            } else if rank[root_x] < rank[root_y] {
                parent[root_x][0] = root_y;
            } else {
                parent[root_y][0] = root_x;
                rank[root_x] += 1;
            }
        }
    }

    for i in 0..(n * 3) {
        for j in 0..(n * 3) {
            parent[i][0] = i;
        }
    }

    for i in 0..n {
        for j in 0..n {
            if grid[i].chars().nth(j).unwrap() == '/' {
                union(&mut parent, &mut rank, i * 3 + j, i * 3 + j + 1);
                union(&mut parent, &mut rank, i * 3 + j + 2, i * 3 + j + 1);
            } else if grid[i].chars().nth(j).unwrap() == '\\' {
                union(&mut parent, &mut rank, i * 3 + j + 1, i * 3 + j);
                union(&mut parent, &mut rank, i * 3 + j + 2, i * 3 + j + 2);
            } else {
                union(&mut parent, &mut rank, i * 3 + j + 1, i * 3 + j + 1);
                union(&mut parent, &mut rank, i * 3 + j + 2, i * 3 + j + 2);
            }
        }
    }

    let mut regions = HashSet::new();
    for i in 0..(n * 3) {
        for j in 0..(n * 3) {
            regions.insert(find(&mut parent, i * 3 + j));
        }
    }

    regions.len() as i32
}
impl Solution {
    pub fn largest_island(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut grid = grid;
        let mut islands = vec![vec![0; n]; n];
        let mut island_sizes = std::collections::HashMap::new();
        let mut island_count = 0;

        fn dfs(grid: &mut Vec<Vec<i32>>, islands: &mut Vec<Vec<i32>>, i: usize, j: usize, island_id: i32, island_sizes: &mut std::collections::HashMap<i32, i32>) -> i32 {
            let n = grid.len();
            if i < 0 || i >= n || j < 0 || j >= n || grid[i][j] == 0 || islands[i][j] != 0 {
                return 0;
            }

            islands[i][j] = island_id;
            let mut size = 1;
            grid[i][j] = 0;

            size += dfs(grid, islands, i + 1, j, island_id, island_sizes);
            size += dfs(grid, islands, i - 1, j, island_id, island_sizes);
            size += dfs(grid, islands, i, j + 1, island_id, island_sizes);
            size += dfs(grid, islands, i, j - 1, island_id, island_sizes);

            size as i32
        }

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 1 && islands[i][j] == 0 {
                    island_count += 1;
                    let size = dfs(&mut grid, &mut islands, i, j, island_count, &mut island_sizes);
                    island_sizes.insert(island_count, size);
                }
            }
        }

        let mut max_island = 0;
        if island_sizes.is_empty() {
            return 1;
        }

        for size in island_sizes.values() {
            max_island = max_island.max(*size);
        }

        for i in 0..n {
            for j in 0..n {
                if islands[i][j] == 0 {
                    let mut adjacent_islands = std::collections::HashSet::new();
                    if i > 0 {
                        adjacent_islands.insert(islands[i - 1][j]);
                    }
                    if i < n - 1 {
                        adjacent_islands.insert(islands[i + 1][j]);
                    }
                    if j > 0 {
                        adjacent_islands.insert(islands[i][j - 1]);
                    }
                    if j < n - 1 {
                        adjacent_islands.insert(islands[i][j + 1]);
                    }

                    let mut new_island_size = 1;
                    for island_id in adjacent_islands {
                        if island_id != 0 {
                            new_island_size += island_sizes.get(&island_id).unwrap();
                        }
                    }
                    max_island = max_island.max(new_island_size);
                }
            }
        }

        max_island
    }
}
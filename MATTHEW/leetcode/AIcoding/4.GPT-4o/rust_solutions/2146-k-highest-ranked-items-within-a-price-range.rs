use std::collections::HashMap;

pub fn highest_ranked_k_items(grid: Vec<Vec<i32>>, pricing: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
    let mut items = Vec::new();
    let (m, n) = (grid.len(), grid[0].len());
    let (low, high) = (pricing[0], pricing[1]);

    for i in 0..m {
        for j in 0..n {
            if grid[i][j] >= 1 && grid[i][j] >= low && grid[i][j] <= high {
                items.push((grid[i][j], i, j));
            }
        }
    }

    items.sort_by(|a, b| {
        if a.0 == b.0 {
            if a.1 == b.1 {
                a.2.cmp(&b.2)
            } else {
                a.1.cmp(&b.1)
            }
        } else {
            a.0.cmp(&b.0).reverse()
        }
    });

    let mut result = Vec::new();
    for i in 0..k.min(items.len() as i32) {
        result.push(vec![items[i as usize].1, items[i as usize].2]);
    }

    result
}
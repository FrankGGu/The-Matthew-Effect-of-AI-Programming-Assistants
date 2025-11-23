use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(points: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut ans = 0;
        let mut map: HashMap<(i32, i32), i32> = HashMap::new(); // Stores (x, y) -> count

        for point in points {
            let x = point[0];
            let y = point[1];

            // For current point (x, y), find previous points (px, py)
            // such that |x - px| + |y - py| = k
            // Let dx = |x - px| and dy = |y - py|
            // We need dx + dy = k
            // dx can range from 0 to k
            for dx in 0..=k {
                let dy = k - dx;

                // We are looking for (px, py) such that:
                // px = x - dx  OR  px = x + dx
                // py = y - dy  OR  py = y + dy

                // Case 1: px = x - dx, py = y - dy
                if let Some(&count) = map.get(&(x - dx, y - dy)) {
                    ans += count;
                }

                // Case 2: px = x - dx, py = y + dy
                // Avoid double counting if dy is 0 (y - dy == y + dy)
                if dy != 0 {
                    if let Some(&count) = map.get(&(x - dx, y + dy)) {
                        ans += count;
                    }
                }

                // Case 3: px = x + dx, py = y - dy
                // Avoid double counting if dx is 0 (x - dx == x + dx)
                if dx != 0 { 
                    if let Some(&count) = map.get(&(x + dx, y - dy)) {
                        ans += count;
                    }
                    // Case 4: px = x + dx, py = y + dy
                    // Avoid double counting if dx is 0 or dy is 0
                    if dy != 0 { 
                        if let Some(&count) = map.get(&(x + dx, y + dy)) {
                            ans += count;
                        }
                    }
                }
            }

            // Add current point to the map (or increment its count)
            *map.entry((x, y)).or_insert(0) += 1;
        }

        ans
    }
}
use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(points: Vec<Vec<i32>>, k: i32) -> i32 {
        let mut count = 0;
        let mut map: HashMap<(i32, i32), i32> = HashMap::new();

        for point in &points {
            let x = point[0];
            let y = point[1];

            for i in 0..=k {
                let j = k - i;
                let target_x = x - i;
                let target_y = y - j;

                if let Some(&val) = map.get(&(target_x, target_y)) {
                    count += val;
                }
            }

            *map.entry((x, y)).or_insert(0) += 1;
        }

        count
    }
}
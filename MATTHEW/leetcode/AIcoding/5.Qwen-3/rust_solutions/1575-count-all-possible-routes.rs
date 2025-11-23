impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_routes(mut locations: Vec<i32>, start: i32, finish: i32, mut fuel: i32) -> i32 {
        let n = locations.len();
        let start = start as usize;
        let finish = finish as usize;
        let mut memo = HashMap::new();

        fn dfs(
            locations: &[i32],
            start: usize,
            finish: usize,
            fuel: i32,
            memo: &mut HashMap<(usize, i32), i32>,
        ) -> i32 {
            if fuel < 0 {
                return 0;
            }
            if let Some(&count) = memo.get(&(start, fuel)) {
                return count;
            }

            let mut count = if start == finish { 1 } else { 0 };

            for next in 0..locations.len() {
                if next != start {
                    let cost = (locations[start] - locations[next]).abs();
                    if fuel >= cost {
                        count += dfs(locations, next, finish, fuel - cost, memo);
                    }
                }
            }

            memo.insert((start, fuel), count);
            count
        }

        dfs(&locations, start, finish, fuel, &mut memo)
    }
}
}
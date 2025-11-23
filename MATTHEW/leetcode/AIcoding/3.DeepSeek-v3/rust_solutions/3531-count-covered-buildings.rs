impl Solution {
    pub fn count_covered_buildings(buildings: Vec<Vec<i32>>) -> i32 {
        if buildings.is_empty() {
            return 0;
        }
        let mut buildings = buildings;
        buildings.sort_by(|a, b| a[0].cmp(&b[0]).then(a[1].cmp(&b[1]));

        let mut merged = Vec::new();
        merged.push(buildings[0].clone());

        for building in buildings.into_iter().skip(1) {
            let last = merged.last_mut().unwrap();
            if building[0] <= last[1] {
                last[1] = last[1].max(building[1]);
            } else {
                merged.push(building);
            }
        }

        let mut count = 0;
        let n = merged.len();
        for i in 0..n {
            let (start, end) = (merged[i][0], merged[i][1]);
            let mut covered = false;
            for j in 0..n {
                if i == j {
                    continue;
                }
                if merged[j][0] <= start && end <= merged[j][1] {
                    covered = true;
                    break;
                }
            }
            if covered {
                count += 1;
            }
        }
        count
    }
}
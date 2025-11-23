impl Solution {
    pub fn dig_artifacts(n: i32, artifacts: Vec<Vec<i32>>, dug: Vec<Vec<i32>>) -> i32 {
        let mut dug_set = std::collections::HashSet::new();
        for d in &dug {
            dug_set.insert((d[0], d[1]));
        }

        let mut count = 0;
        for artifact in &artifacts {
            let r1 = artifact[0];
            let c1 = artifact[1];
            let r2 = artifact[2];
            let c2 = artifact[3];

            let mut extracted = true;
            for r in r1..=r2 {
                for c in c1..=c2 {
                    if !dug_set.contains(&(r, c)) {
                        extracted = false;
                        break;
                    }
                }
                if !extracted {
                    break;
                }
            }

            if extracted {
                count += 1;
            }
        }

        count
    }
}
impl Solution {
    pub fn dig_artifacts(n: i32, artifacts: Vec<Vec<i32>>, dig: Vec<Vec<i32>>) -> i32 {
        use std::collections::HashSet;
        let mut dug = HashSet::new();
        for d in dig {
            dug.insert((d[0] as usize, d[1] as usize));
        }
        let mut count = 0;
        for artifact in artifacts {
            let r1 = artifact[0] as usize;
            let c1 = artifact[1] as usize;
            let r2 = artifact[2] as usize;
            let c2 = artifact[3] as usize;
            let mut all_dug = true;
            for r in r1..=r2 {
                for c in c1..=c2 {
                    if !dug.contains(&(r, c)) {
                        all_dug = false;
                        break;
                    }
                }
                if !all_dug {
                    break;
                }
            }
            if all_dug {
                count += 1;
            }
        }
        count
    }
}
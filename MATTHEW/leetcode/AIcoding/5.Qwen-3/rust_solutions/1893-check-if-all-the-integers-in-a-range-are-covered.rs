struct Solution;

impl Solution {
    pub fn is_covered(range: Vec<Vec<i32>>, left: i32, right: i32) -> bool {
        let mut covered = vec![false; 101];

        for r in range {
            let start = r[0];
            let end = r[1];
            for i in start..=end {
                covered[i as usize] = true;
            }
        }

        for i in left..=right {
            if !covered[i as usize] {
                return false;
            }
        }

        true
    }
}
impl Solution {
    pub fn min_domino_rotations(tops: Vec<i32>, bottoms: Vec<i32>) -> i32 {
        let n = tops.len();
        let mut ans = i32::MAX;

        for target in [tops[0], bottoms[0]].iter() {
            let mut top_rotations = 0;
            let mut bottom_rotations = 0;
            let mut possible = true;

            for i in 0..n {
                if tops[i] != *target && bottoms[i] != *target {
                    possible = false;
                    break;
                }

                if tops[i] != *target {
                    top_rotations += 1;
                }

                if bottoms[i] != *target {
                    bottom_rotations += 1;
                }
            }

            if possible {
                ans = ans.min(top_rotations.min(bottom_rotations));
            }
        }

        if ans == i32::MAX {
            -1
        } else {
            ans
        }
    }
}
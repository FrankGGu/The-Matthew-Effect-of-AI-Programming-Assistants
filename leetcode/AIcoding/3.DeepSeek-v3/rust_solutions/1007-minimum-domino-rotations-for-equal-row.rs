impl Solution {
    pub fn min_domino_rotations(tops: Vec<i32>, bottoms: Vec<i32>) -> i32 {
        fn check(x: i32, tops: &[i32], bottoms: &[i32]) -> i32 {
            let mut rotations_top = 0;
            let mut rotations_bottom = 0;
            for i in 0..tops.len() {
                if tops[i] != x && bottoms[i] != x {
                    return -1;
                }
                if tops[i] != x {
                    rotations_top += 1;
                } else if bottoms[i] != x {
                    rotations_bottom += 1;
                }
            }
            rotations_top.min(rotations_bottom)
        }

        let rotations = check(tops[0], &tops, &bottoms);
        if rotations != -1 || tops[0] == bottoms[0] {
            return rotations;
        }
        check(bottoms[0], &tops, &bottoms)
    }
}
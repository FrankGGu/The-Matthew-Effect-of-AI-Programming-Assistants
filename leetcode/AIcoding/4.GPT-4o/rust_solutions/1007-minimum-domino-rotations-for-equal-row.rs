pub fn min_domino_rotations(tops: Vec<i32>, bottoms: Vec<i32>) -> i32 {
    fn check(x: i32, tops: &Vec<i32>, bottoms: &Vec<i32>) -> i32 {
        let mut rotations_a = 0;
        let mut rotations_b = 0;
        for i in 0..tops.len() {
            if tops[i] != x && bottoms[i] != x {
                return -1;
            } else if tops[i] != x {
                rotations_a += 1;
            } else if bottoms[i] != x {
                rotations_b += 1;
            }
        }
        rotations_a.min(rotations_b)
    }

    let result = check(tops[0], &tops, &bottoms).min(check(bottoms[0], &tops, &bottoms));
    if result == -1 { -1 } else { result }
}
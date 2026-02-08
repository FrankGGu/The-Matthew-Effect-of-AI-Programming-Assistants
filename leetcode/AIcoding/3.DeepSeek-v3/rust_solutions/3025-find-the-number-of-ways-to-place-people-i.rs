impl Solution {
    pub fn number_of_pairs(points: Vec<Vec<i32>>) -> i32 {
        let mut count = 0;
        let n = points.len();
        for i in 0..n {
            for j in 0..n {
                if i == j {
                    continue;
                }
                let (x1, y1) = (points[i][0], points[i][1]);
                let (x2, y2) = (points[j][0], points[j][1]);
                if x1 <= x2 && y1 >= y2 {
                    let mut valid = true;
                    for k in 0..n {
                        if k == i || k == j {
                            continue;
                        }
                        let (x, y) = (points[k][0], points[k][1]);
                        if x >= x1 && x <= x2 && y <= y1 && y >= y2 {
                            valid = false;
                            break;
                        }
                    }
                    if valid {
                        count += 1;
                    }
                }
            }
        }
        count
    }
}
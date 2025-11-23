impl Solution {
    pub fn number_of_ways(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let mut count = 0;
        for i in 0..n {
            for j in 0..n {
                if i == j {
                    continue;
                }
                if points[i][0] <= points[j][0] && points[i][1] <= points[j][1] {
                    let mut blocked = false;
                    for k in 0..n {
                        if k == i || k == j {
                            continue;
                        }
                        if points[i][0] <= points[k][0] && points[k][0] <= points[j][0] && points[i][1] >= points[k][1] && points[k][1] <= points[j][1] {
                            blocked = true;
                            break;
                        }
                    }
                    if !blocked {
                        count += 1;
                    }
                }
            }
        }
        count as i32
    }
}
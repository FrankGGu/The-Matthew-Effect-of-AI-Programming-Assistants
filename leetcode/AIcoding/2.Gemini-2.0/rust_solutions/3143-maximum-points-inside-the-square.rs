impl Solution {
    pub fn max_points_inside_square(points: Vec<Vec<i32>>, side: i32) -> i32 {
        let mut max_count = 0;
        for i in 0..points.len() {
            for j in 0..points.len() {
                let x1 = points[i][0];
                let y1 = points[i][1];
                let x2 = points[j][0];
                let y2 = points[j][1];

                let mut count1 = 0;
                let mut count2 = 0;
                let mut count3 = 0;
                let mut count4 = 0;

                for k in 0..points.len() {
                    let x = points[k][0];
                    let y = points[k][1];

                    if x >= x1 && x <= x1 + side && y >= y1 && y <= y1 + side {
                        count1 += 1;
                    }
                    if x >= x1 && x <= x1 + side && y >= y2 - side && y <= y2 {
                        count2 += 1;
                    }
                    if x >= x2 - side && x <= x2 && y >= y1 && y <= y1 + side {
                        count3 += 1;
                    }
                    if x >= x2 - side && x <= x2 && y >= y2 - side && y <= y2 {
                        count4 += 1;
                    }
                }
                max_count = max_count.max(count1);
                max_count = max_count.max(count2);
                max_count = max_count.max(count3);
                max_count = max_count.max(count4);
            }
        }
        max_count
    }
}
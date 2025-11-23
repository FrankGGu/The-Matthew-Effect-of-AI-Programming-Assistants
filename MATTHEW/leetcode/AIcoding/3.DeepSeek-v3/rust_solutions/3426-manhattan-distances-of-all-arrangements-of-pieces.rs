impl Solution {
    pub fn minimum_distance(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let mut max1 = std::i32::MIN;
        let mut max2 = std::i32::MIN;
        let mut max3 = std::i32::MIN;
        let mut max4 = std::i32::MIN;
        let mut min1 = std::i32::MAX;
        let mut min2 = std::i32::MAX;
        let mut min3 = std::i32::MAX;
        let mut min4 = std::i32::MAX;

        for point in &points {
            let x = point[0];
            let y = point[1];
            max1 = max1.max(x + y);
            min1 = min1.min(x + y);
            max2 = max2.max(x - y);
            min2 = min2.min(x - y);
            max3 = max3.max(-x + y);
            min3 = min3.min(-x + y);
            max4 = max4.max(-x - y);
            min4 = min4.min(-x - y);
        }

        let mut res = std::i32::MAX;
        for i in 0..n {
            let x = points[i][0];
            let y = points[i][1];
            let mut current_max1 = if x + y == max1 {
                let mut temp = std::i32::MIN;
                for point in &points {
                    if point[0] + point[1] != max1 {
                        temp = temp.max(point[0] + point[1]);
                    }
                }
                temp
            } else {
                max1
            };
            let mut current_min1 = if x + y == min1 {
                let mut temp = std::i32::MAX;
                for point in &points {
                    if point[0] + point[1] != min1 {
                        temp = temp.min(point[0] + point[1]);
                    }
                }
                temp
            } else {
                min1
            };
            let mut current_max2 = if x - y == max2 {
                let mut temp = std::i32::MIN;
                for point in &points {
                    if point[0] - point[1] != max2 {
                        temp = temp.max(point[0] - point[1]);
                    }
                }
                temp
            } else {
                max2
            };
            let mut current_min2 = if x - y == min2 {
                let mut temp = std::i32::MAX;
                for point in &points {
                    if point[0] - point[1] != min2 {
                        temp = temp.min(point[0] - point[1]);
                    }
                }
                temp
            } else {
                min2
            };
            let mut current_max3 = if -x + y == max3 {
                let mut temp = std::i32::MIN;
                for point in &points {
                    if -point[0] + point[1] != max3 {
                        temp = temp.max(-point[0] + point[1]);
                    }
                }
                temp
            } else {
                max3
            };
            let mut current_min3 = if -x + y == min3 {
                let mut temp = std::i32::MAX;
                for point in &points {
                    if -point[0] + point[1] != min3 {
                        temp = temp.min(-point[0] + point[1]);
                    }
                }
                temp
            } else {
                min3
            };
            let mut current_max4 = if -x - y == max4 {
                let mut temp = std::i32::MIN;
                for point in &points {
                    if -point[0] - point[1] != max4 {
                        temp = temp.max(-point[0] - point[1]);
                    }
                }
                temp
            } else {
                max4
            };
            let mut current_min4 = if -x - y == min4 {
                let mut temp = std::i32::MAX;
                for point in &points {
                    if -point[0] - point[1] != min4 {
                        temp = temp.min(-point[0] - point[1]);
                    }
                }
                temp
            } else {
                min4
            };

            let candidate1 = current_max1 - current_min1;
            let candidate2 = current_max2 - current_min2;
            let candidate3 = current_max3 - current_min3;
            let candidate4 = current_max4 - current_min4;
            let current_max = candidate1.max(candidate2).max(candidate3).max(candidate4);
            res = res.min(current_max);
        }
        res
    }
}
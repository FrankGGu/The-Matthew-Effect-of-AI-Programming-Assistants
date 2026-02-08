use std::collections::HashMap;

pub struct CountRectangles {
    rectangles: Vec<Vec<i32>>,
    count_map: HashMap<i32, Vec<i32>>,
}

impl CountRectangles {
    pub fn new(rectangles: Vec<Vec<i32>>) -> Self {
        let mut count_map = HashMap::new();
        for rect in &rectangles {
            let (x1, y1, x2, y2) = (rect[0], rect[1], rect[2], rect[3]);
            count_map.entry(x1).or_insert(vec![0; 101])[y2 as usize] += 1;
        }
        CountRectangles { rectangles, count_map }
    }

    pub fn count(&self, points: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        for point in points {
            let (x, y) = (point[0], point[1]);
            let mut count = 0;
            for (&x1, &heights) in &self.count_map {
                if x1 >= x {
                    break;
                }
                for h in heights.iter().take((y + 1) as usize).rev() {
                    count += h;
                }
            }
            result.push(count);
        }
        result
    }
}
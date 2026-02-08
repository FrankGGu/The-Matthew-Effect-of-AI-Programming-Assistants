impl Solution {
    pub fn count_rectangles(rectangles: Vec<Vec<i32>>, points: Vec<Vec<i32>>) -> Vec<i32> {
        let mut rects: Vec<(i32, i32)> = rectangles.iter().map(|r| (r[0], r[1])).collect();
        rects.sort_by_key(|&(l, h)| (l, h));

        let mut ans = Vec::new();
        for point in &points {
            let x = point[0];
            let y = point[1];
            let mut count = 0;
            for rect in &rects {
                if rect.0 >= x && rect.1 >= y {
                    count += 1;
                }
            }
            ans.push(count);
        }
        ans
    }
}
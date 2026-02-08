impl Solution {
    pub fn count_rectangles(rectangles: Vec<Vec<i32>>, points: Vec<Vec<i32>>) -> Vec<i32> {
        const MAX_H: usize = 100;
        let mut rects_by_height: Vec<Vec<i32>> = vec![vec![]; MAX_H + 1];

        for rect in rectangles {
            let l = rect[0];
            let h = rect[1] as usize;
            rects_by_height[h].push(l);
        }

        for h in 1..=MAX_H {
            rects_by_height[h].sort_unstable();
        }

        let mut answer: Vec<i32> = vec![0; points.len()];

        for (i, point) in points.iter().enumerate() {
            let xj = point[0];
            let yj = point[1] as usize;

            let mut count = 0;
            for h_rect in yj..=MAX_H {
                let rect_lengths = &rects_by_height[h_rect];

                let idx = match rect_lengths.binary_search(&xj) {
                    Ok(j) => j,
                    Err(j) => j,
                };

                count += (rect_lengths.len() - idx) as i32;
            }
            answer[i] = count;
        }

        answer
    }
}
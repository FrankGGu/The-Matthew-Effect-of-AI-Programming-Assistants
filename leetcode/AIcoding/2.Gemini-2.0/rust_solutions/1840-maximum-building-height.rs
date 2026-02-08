impl Solution {
    pub fn max_building(n: i32, restrictions: Vec<Vec<i32>>) -> i32 {
        let mut restrictions = restrictions;
        restrictions.push(vec![1, 0]);
        restrictions.push(vec![n, n - 1]);
        restrictions.sort_by_key(|r| r[0]);

        let m = restrictions.len();
        let mut heights = vec![0; m];
        for i in 0..m {
            heights[i] = restrictions[i][1];
        }

        for i in 1..m {
            heights[i] = heights[i].min(heights[i - 1] + restrictions[i][0] - restrictions[i - 1][0]);
        }

        for i in (0..m - 1).rev() {
            heights[i] = heights[i].min(heights[i + 1] + restrictions[i + 1][0] - restrictions[i][0]);
        }

        let mut max_height = 0;
        for i in 0..m - 1 {
            let dist = restrictions[i + 1][0] - restrictions[i][0];
            let h1 = heights[i];
            let h2 = heights[i + 1];
            let diff = (h1 - h2).abs();
            if diff >= dist {
                max_height = max_height.max(h1.max(h2) + dist);
            } else {
                let remaining = dist - diff;
                let max_h = h1.max(h2) + remaining / 2;
                max_height = max_height.max(max_h);
            }
        }

        max_height
    }
}
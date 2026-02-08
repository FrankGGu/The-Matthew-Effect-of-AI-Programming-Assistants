impl Solution {
    pub fn color_the_array(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut colors = vec![0; n as usize];
        let mut res = Vec::with_capacity(queries.len());
        let mut count = 0;

        for query in queries {
            let (i, color) = (query[0] as usize, query[1]);
            let prev_color = colors[i];

            if prev_color != 0 {
                if i > 0 && colors[i - 1] == prev_color {
                    count -= 1;
                }
                if i + 1 < colors.len() && colors[i + 1] == prev_color {
                    count -= 1;
                }
            }

            colors[i] = color;

            if color != 0 {
                if i > 0 && colors[i - 1] == color {
                    count += 1;
                }
                if i + 1 < colors.len() && colors[i + 1] == color {
                    count += 1;
                }
            }

            res.push(count);
        }

        res
    }
}
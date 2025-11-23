impl Solution {
    pub fn color_the_array(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut colors = vec![0; n as usize];
        let mut res = Vec::with_capacity(queries.len());
        let mut count = 0;

        for query in queries {
            let index = query[0] as usize;
            let new_color = query[1];

            if colors[index] != 0 {
                if index > 0 && colors[index] == colors[index - 1] {
                    count -= 1;
                }
                if index < colors.len() - 1 && colors[index] == colors[index + 1] {
                    count -= 1;
                }
            }

            colors[index] = new_color;

            if index > 0 && colors[index] == colors[index - 1] {
                count += 1;
            }
            if index < colors.len() - 1 && colors[index] == colors[index + 1] {
                count += 1;
            }

            res.push(count);
        }

        res
    }
}
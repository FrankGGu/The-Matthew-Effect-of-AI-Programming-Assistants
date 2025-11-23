impl Solution {
    pub fn number_of_adjacent_elements_with_the_same_color(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut colors = vec![0; n as usize];
        let mut ans = Vec::new();
        let mut count = 0;

        for query in &queries {
            let index = query[0] as usize;
            let color = query[1];

            if colors[index] != 0 {
                if index > 0 && colors[index - 1] == colors[index] {
                    count -= 1;
                }
                if index < (n - 1) as usize && colors[index + 1] == colors[index] {
                    count -= 1;
                }
            }

            colors[index] = color;

            if index > 0 && colors[index - 1] == colors[index] {
                count += 1;
            }
            if index < (n - 1) as usize && colors[index + 1] == colors[index] {
                count += 1;
            }

            ans.push(count);
        }

        ans
    }
}
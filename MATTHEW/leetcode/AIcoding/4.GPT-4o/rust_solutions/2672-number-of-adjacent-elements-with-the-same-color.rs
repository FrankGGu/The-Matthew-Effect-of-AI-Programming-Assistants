pub fn color_the_array(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
    let mut colors = vec![0; n as usize];
    let mut adjacent_pairs = 0;
    let mut results = Vec::new();

    for query in queries {
        let index = query[0] as usize;
        let color = query[1];

        if colors[index] != 0 {
            if index > 0 && colors[index] == colors[index - 1] {
                adjacent_pairs -= 1;
            }
            if index < n as usize - 1 && colors[index] == colors[index + 1] {
                adjacent_pairs -= 1;
            }
        }

        colors[index] = color;

        if index > 0 && colors[index] == colors[index - 1] {
            adjacent_pairs += 1;
        }
        if index < n as usize - 1 && colors[index] == colors[index + 1] {
            adjacent_pairs += 1;
        }

        results.push(adjacent_pairs);
    }

    results
}
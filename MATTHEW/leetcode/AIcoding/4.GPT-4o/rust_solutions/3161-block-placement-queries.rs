pub fn block_placement_queries(blocks: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
    let mut res = Vec::new();
    for query in queries {
        let (x1, y1, x2, y2) = (query[0], query[1], query[2], query[3]);
        let mut count = 0;
        for i in x1..=x2 {
            for j in y1..=y2 {
                count += blocks[i as usize][j as usize];
            }
        }
        res.push(count);
    }
    res
}
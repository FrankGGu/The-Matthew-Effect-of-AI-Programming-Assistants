impl Solution {
    pub fn process_queries(queries: Vec<i32>, m: i32) -> Vec<i32> {
        let mut p: Vec<i32> = (1..=m).collect();
        let mut results: Vec<i32> = Vec::with_capacity(queries.len());

        for query in queries {
            let mut index = 0;
            for i in 0..p.len() {
                if p[i] == query {
                    index = i as i32;
                    break;
                }
            }
            results.push(index);

            let val = p.remove(index as usize);
            p.insert(0, val);
        }

        results
    }
}
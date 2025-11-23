impl Solution {
    pub fn process_queries(queries: Vec<i32>, m: i32) -> Vec<i32> {
        let mut p: Vec<i32> = (1..=m).collect();
        let mut result: Vec<i32> = Vec::new();

        for &query in &queries {
            let mut index = 0;
            for i in 0..p.len() {
                if p[i] == query {
                    index = i;
                    break;
                }
            }

            result.push(index as i32);
            p.remove(index);
            p.insert(0, query);
        }

        result
    }
}
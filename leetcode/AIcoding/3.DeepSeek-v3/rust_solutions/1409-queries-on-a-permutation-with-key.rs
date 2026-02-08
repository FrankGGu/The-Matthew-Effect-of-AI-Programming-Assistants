impl Solution {
    pub fn process_queries(queries: Vec<i32>, m: i32) -> Vec<i32> {
        let mut p: Vec<i32> = (1..=m).collect();
        let mut res = Vec::new();
        for &query in querys.iter() {
            let pos = p.iter().position(|&x| x == query).unwrap() as i32;
            res.push(pos);
            p.remove(pos as usize);
            p.insert(0, query);
        }
        res
    }
}
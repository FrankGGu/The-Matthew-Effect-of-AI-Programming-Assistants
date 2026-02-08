impl Solution {
    pub fn group_the_people(group_sizes: Vec<i32>) -> Vec<Vec<i32>> {
        use std::collections::HashMap;

        let mut groups: HashMap<i32, Vec<i32>> = HashMap::new();
        let mut result: Vec<Vec<i32>> = Vec::new();

        for (i, &size) in group_sizes.iter().enumerate() {
            groups.entry(size).or_insert(Vec::new()).push(i as i32);
        }

        for (size, indices) in groups {
            let mut chunked = indices.chunks(size as usize);
            while let Some(chunk) = chunked.next() {
                result.push(chunk.to_vec());
            }
        }

        result
    }
}
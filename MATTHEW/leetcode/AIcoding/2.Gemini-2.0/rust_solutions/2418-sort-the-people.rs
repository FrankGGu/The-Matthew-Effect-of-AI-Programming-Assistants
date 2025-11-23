impl Solution {
    pub fn sort_people(names: Vec<String>, heights: Vec<i32>) -> Vec<String> {
        let mut people: Vec<(&String, i32)> = names.iter().zip(heights.into_iter()).collect();
        people.sort_by(|a, b| b.1.cmp(&a.1));
        people.into_iter().map(|(name, _)| name.clone()).collect()
    }
}
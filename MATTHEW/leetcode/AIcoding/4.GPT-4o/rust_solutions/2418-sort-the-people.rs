impl Solution {
    pub fn sort_people(names: Vec<String>, heights: Vec<i32>) -> Vec<String> {
        let mut people: Vec<(String, i32)> = names.into_iter().zip(heights).collect();
        people.sort_by(|a, b| b.1.cmp(&a.1));
        people.into_iter().map(|(name, _)| name).collect()
    }
}
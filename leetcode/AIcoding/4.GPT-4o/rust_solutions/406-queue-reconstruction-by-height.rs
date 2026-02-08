impl Solution {
    pub fn reconstruct_queue(people: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut people = people;
        people.sort_by(|a, b| if a[0] == b[0] { a[1].cmp(&b[1]) } else { b[0].cmp(&a[0]) });
        let mut result = Vec::new();
        for person in people {
            result.insert(person[1] as usize, person);
        }
        result
    }
}
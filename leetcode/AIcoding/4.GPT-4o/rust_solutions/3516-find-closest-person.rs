impl Solution {
    pub fn find_closest_person(people: Vec<i32>, target: i32) -> i32 {
        let mut closest = -1;
        let mut min_diff = i32::MAX;

        for &person in &people {
            let diff = (person - target).abs();
            if diff < min_diff {
                min_diff = diff;
                closest = person;
            } else if diff == min_diff {
                closest = closest.max(person);
            }
        }
        closest
    }
}
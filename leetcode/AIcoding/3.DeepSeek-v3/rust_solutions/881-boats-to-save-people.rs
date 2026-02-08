impl Solution {
    pub fn num_rescue_boats(people: Vec<i32>, limit: i32) -> i32 {
        let mut people = people;
        people.sort_unstable();
        let mut left = 0;
        let mut right = people.len() as i32 - 1;
        let mut boats = 0;

        while left <= right {
            if people[left as usize] + people[right as usize] <= limit {
                left += 1;
            }
            right -= 1;
            boats += 1;
        }

        boats
    }
}
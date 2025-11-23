impl Solution {
    pub fn num_rescue_boats(mut people: Vec<i32>, limit: i32) -> i32 {
        people.sort_unstable();

        let mut boats = 0;
        let mut left = 0;
        let mut right = people.len() - 1;

        while left <= right {
            boats += 1;
            if people[left] + people[right] <= limit {
                left += 1;
            }
            right -= 1;
        }

        boats
    }
}
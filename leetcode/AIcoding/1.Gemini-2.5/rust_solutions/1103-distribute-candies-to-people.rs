impl Solution {
    pub fn distribute_candies(candies: i32, num_people: i32) -> Vec<i32> {
        let mut result = vec![0; num_people as usize];
        let mut remaining_candies = candies;
        let mut current_give = 1;
        let mut person_idx = 0;

        while remaining_candies > 0 {
            let give_amount = std::cmp::min(current_give, remaining_candies);
            result[person_idx as usize] += give_amount;
            remaining_candies -= give_amount;
            current_give += 1;
            person_idx = (person_idx + 1) % num_people;
        }

        result
    }
}
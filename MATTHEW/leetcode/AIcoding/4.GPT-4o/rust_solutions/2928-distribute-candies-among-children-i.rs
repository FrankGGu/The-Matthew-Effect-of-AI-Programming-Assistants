impl Solution {
    pub fn distribute_candies(candies: i32, num_people: i32) -> Vec<i32> {
        let mut result = vec![0; num_people as usize];
        let mut candies_left = candies;
        let mut i = 0;
        while candies_left > 0 {
            let give = std::cmp::min(candies_left, (i as i32) + 1);
            result[i as usize] += give;
            candies_left -= give;
            i = (i + 1) % num_people;
        }
        result
    }
}
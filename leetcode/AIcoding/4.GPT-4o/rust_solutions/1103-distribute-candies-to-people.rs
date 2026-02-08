impl Solution {
    pub fn distribute_candies(candies: i32, num_people: i32) -> Vec<i32> {
        let mut result = vec![0; num_people as usize];
        let mut i = 0;
        let mut total_candies = candies;

        while total_candies > 0 {
            let to_give = std::cmp::min(total_candies, i + 1);
            result[i % num_people as usize] += to_give;
            total_candies -= to_give;
            i += 1;
        }

        result
    }
}
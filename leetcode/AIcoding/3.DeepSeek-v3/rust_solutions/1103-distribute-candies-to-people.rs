impl Solution {
    pub fn distribute_candies(candies: i32, num_people: i32) -> Vec<i32> {
        let mut candies_left = candies;
        let mut result = vec![0; num_people as usize];
        let mut give = 1;
        let mut i = 0;

        while candies_left > 0 {
            let actual_give = std::cmp::min(give, candies_left);
            result[i] += actual_give;
            candies_left -= actual_give;
            give += 1;
            i = (i + 1) % (num_people as usize);
        }

        result
    }
}
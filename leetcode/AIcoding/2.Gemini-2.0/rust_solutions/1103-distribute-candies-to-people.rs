impl Solution {
    pub fn distribute_candies(candies: i32, num_people: i32) -> Vec<i32> {
        let mut res = vec![0; num_people as usize];
        let mut candies_left = candies;
        let mut give = 1;
        let mut i = 0;

        while candies_left > 0 {
            let idx = i % num_people as i32;
            if candies_left >= give {
                res[idx as usize] += give;
                candies_left -= give;
                give += 1;
            } else {
                res[idx as usize] += candies_left;
                candies_left = 0;
            }
            i += 1;
        }

        res
    }
}
impl Solution {
    pub fn num_teams(rating: Vec<i32>) -> i32 {
        let n = rating.len();
        let mut count = 0;
        for i in 0..n {
            for j in i + 1..n {
                for k in j + 1..n {
                    if (rating[i] < rating[j] && rating[j] < rating[k]) ||
                       (rating[i] > rating[j] && rating[j] > rating[k]) {
                        count += 1;
                    }
                }
            }
        }
        count
    }
}
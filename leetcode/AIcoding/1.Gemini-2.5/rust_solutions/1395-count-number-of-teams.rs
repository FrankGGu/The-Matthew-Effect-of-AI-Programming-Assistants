impl Solution {
    pub fn num_teams(rating: Vec<i32>) -> i32 {
        let n = rating.len();
        if n < 3 {
            return 0;
        }

        let mut teams = 0;

        for j in 1..n - 1 {
            let mut left_less = 0;
            let mut left_greater = 0;
            let mut right_less = 0;
            let mut right_greater = 0;

            for i in 0..j {
                if rating[i] < rating[j] {
                    left_less += 1;
                } else if rating[i] > rating[j] {
                    left_greater += 1;
                }
            }

            for k in j + 1..n {
                if rating[k] < rating[j] {
                    right_less += 1;
                } else if rating[k] > rating[j] {
                    right_greater += 1;
                }
            }

            teams += left_less * right_greater;
            teams += left_greater * right_less;
        }

        teams
    }
}
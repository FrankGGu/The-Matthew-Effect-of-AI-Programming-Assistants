impl Solution {
    pub fn num_teams(ranks: Vec<i32>) -> i32 {
        let n = ranks.len();
        let mut count = 0;

        for i in 0..n {
            let (mut left_smaller, mut left_greater, mut right_smaller, mut right_greater) = (0, 0, 0, 0);
            for j in 0..n {
                if ranks[j] < ranks[i] {
                    if j < i {
                        left_smaller += 1;
                    } else {
                        right_smaller += 1;
                    }
                } else if ranks[j] > ranks[i] {
                    if j < i {
                        left_greater += 1;
                    } else {
                        right_greater += 1;
                    }
                }
            }
            count += left_smaller * right_greater + left_greater * right_smaller;
        }

        count
    }
}
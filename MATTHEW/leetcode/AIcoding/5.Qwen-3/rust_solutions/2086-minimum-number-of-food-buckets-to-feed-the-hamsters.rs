struct Solution;

impl Solution {
    pub fn min_food_buckets(hamsters: String) -> i32 {
        let mut hamsters = hamsters.chars().collect::<Vec<char>>();
        let n = hamsters.len();
        let mut res = 0;

        for i in 0..n {
            if hamsters[i] == 'H' {
                if i + 1 < n && hamsters[i + 1] == 'H' {
                    res += 1;
                    hamsters[i + 1] = 'F';
                } else {
                    res += 1;
                }
            }
        }

        res
    }
}
impl Solution {
    pub fn num_friend_requests(ages: Vec<i32>) -> i32 {
        let mut count = vec![0; 121];
        for &age in &ages {
            count[age as usize] += 1;
        }

        let mut prefix = vec![0; 121];
        for i in 1..121 {
            prefix[i] = prefix[i - 1] + count[i];
        }

        let mut res = 0;
        for age in 15..121 {
            if count[age] == 0 {
                continue;
            }
            let lower_bound = age / 2 + 7;
            let cnt = prefix[age] - prefix[lower_bound] - 1;
            res += cnt * count[age];
        }
        res
    }
}
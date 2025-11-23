impl Solution {
    pub fn security_check(people: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut max_time = 0;

        for time in people {
            if time > max_time {
                max_time = time;
                count = 1;
            } else if time == max_time {
                count += 1;
            }
        }

        count
    }
}
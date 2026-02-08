impl Solution {
    pub fn minimum_time(time: Vec<i32>) -> i32 {
        let n = time.len();
        let mut current_time = 0;

        for i in 0..n - 1 {
            if current_time <= time[i] {
                current_time = time[i] + 1;
            } else {
                current_time += 1;
            }
        }

        current_time
    }
}
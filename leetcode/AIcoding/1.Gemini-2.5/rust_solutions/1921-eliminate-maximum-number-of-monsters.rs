impl Solution {
    pub fn eliminate_maximum(dist: Vec<i32>, speed: Vec<i32>) -> i32 {
        let n = dist.len();
        let mut time_to_reach_city: Vec<i32> = Vec::with_capacity(n);

        for i in 0..n {
            time_to_reach_city.push(dist[i] / speed[i]);
        }

        time_to_reach_city.sort_unstable();

        let mut eliminated_count = 0;
        let mut current_time = 0;

        for i in 0..n {
            if time_to_reach_city[i] > current_time {
                eliminated_count += 1;
                current_time += 1;
            } else {
                break;
            }
        }

        eliminated_count
    }
}
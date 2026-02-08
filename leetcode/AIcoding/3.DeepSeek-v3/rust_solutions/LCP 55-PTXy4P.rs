impl Solution {
    pub fn get_minimum_time(time: Vec<i32>, fruits: Vec<Vec<i32>>, limit: i32) -> i32 {
        let mut total_time = 0;
        for fruit in fruits {
            let (fruit_type, num) = (fruit[0] as usize, fruit[1]);
            let t = time[fruit_type];
            total_time += ((num + limit - 1) / limit) * t;
        }
        total_time
    }
}
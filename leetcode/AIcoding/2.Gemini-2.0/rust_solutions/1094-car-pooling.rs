impl Solution {
    pub fn car_pooling(trips: Vec<Vec<i32>>, capacity: i32) -> bool {
        let mut stops = [0; 1001];
        for trip in &trips {
            stops[trip[1] as usize] += trip[0];
            stops[trip[2] as usize] -= trip[0];
        }

        let mut current_capacity = 0;
        for stop in &stops {
            current_capacity += *stop;
            if current_capacity > capacity {
                return false;
            }
        }

        true
    }
}
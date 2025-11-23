impl Solution {
    pub fn car_pooling(trips: Vec<Vec<i32>>, capacity: i32) -> bool {
        let mut events = Vec::new();
        for trip in trips {
            events.push((trip[1], trip[0]));
            events.push((trip[2], -trip[0]));
        }
        events.sort_unstable();

        let mut current = 0;
        for (_, change) in events {
            current += change;
            if current > capacity {
                return false;
            }
        }
        true
    }
}
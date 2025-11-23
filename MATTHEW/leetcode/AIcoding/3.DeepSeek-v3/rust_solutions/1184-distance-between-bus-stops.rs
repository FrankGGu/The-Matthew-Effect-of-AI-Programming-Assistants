impl Solution {
    pub fn distance_between_bus_stops(distance: Vec<i32>, start: i32, destination: i32) -> i32 {
        let (start, destination) = if start < destination {
            (start as usize, destination as usize)
        } else {
            (destination as usize, start as usize)
        };
        let total: i32 = distance.iter().sum();
        let clockwise: i32 = distance[start..destination].iter().sum();
        clockwise.min(total - clockwise)
    }
}
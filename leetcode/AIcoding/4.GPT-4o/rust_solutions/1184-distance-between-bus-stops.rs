impl Solution {
    pub fn distance_between_bus_stops(distance: Vec<i32>, start: i32, destination: i32) -> i32 {
        let n = distance.len() as i32;
        let (start, destination) = (start.min(destination), start.max(destination));
        let clockwise_distance: i32 = distance[start as usize..destination as usize].iter().sum();
        let total_distance: i32 = distance.iter().sum();
        total_distance - clockwise_distance.min(total_distance - clockwise_distance)
    }
}
impl Solution {
    pub fn distance_between_bus_stops(distance: Vec<i32>, start: i32, destination: i32) -> i32 {
        let total_distance: i32 = distance.iter().sum();

        let mut current_distance_one_way = 0;

        let (s, d) = if start < destination {
            (start, destination)
        } else {
            (destination, start)
        };

        for i in s..d {
            current_distance_one_way += distance[i as usize];
        }

        let current_distance_other_way = total_distance - current_distance_one_way;

        current_distance_one_way.min(current_distance_other_way)
    }
}
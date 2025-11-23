impl Solution {
    pub fn distance_between_bus_stops(distance: Vec<i32>, start: i32, destination: i32) -> i32 {
        let n = distance.len();
        let start = start as usize;
        let destination = destination as usize;

        let mut forward_dist = 0;
        let mut backward_dist = 0;

        let mut i = start;
        while i != destination {
            forward_dist += distance[i];
            i = (i + 1) % n;
        }

        let mut i = destination;
        while i != start {
            backward_dist += distance[i];
            i = (i + 1) % n;
        }

        forward_dist.min(backward_dist)
    }
}
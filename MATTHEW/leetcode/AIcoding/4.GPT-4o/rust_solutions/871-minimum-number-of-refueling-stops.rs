pub fn min_refuel_stops(target: i32, start_fuel: i32, stations: Vec<Vec<i32>>) -> i32 {
    use std::collections::BinaryHeap;

    let mut max_heap = BinaryHeap::new();
    let mut current_fuel = start_fuel;
    let mut stops = 0;
    let mut station_index = 0;
    let n = stations.len();

    for i in 0..=n {
        let distance = if i == n { target } else { stations[i][0] };

        while current_fuel < distance {
            if max_heap.is_empty() {
                return -1;
            }
            current_fuel += max_heap.pop().unwrap();
            stops += 1;
        }

        if i < n {
            max_heap.push(stations[i][1]);
        }
    }

    stops
}
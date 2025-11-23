pub fn can_reach_destination(distance: i32, fuel: i32, stations: Vec<i32>) -> bool {
    let mut current_fuel = fuel;
    let mut current_position = 0;

    for &station in &stations {
        if station > distance {
            break;
        }

        if station > current_position {
            let required_fuel = station - current_position;
            if current_fuel < required_fuel {
                return false;
            }
            current_fuel -= required_fuel;
            current_position = station;
        }

        current_fuel += 1; // refuel at the station
    }

    current_fuel >= distance - current_position
}
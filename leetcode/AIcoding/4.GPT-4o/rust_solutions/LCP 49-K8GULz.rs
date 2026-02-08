pub fn can_complete_circuit(gas: Vec<i32>, cost: Vec<i32>) -> i32 {
    let n = gas.len();
    let mut total_tank = 0;
    let mut current_tank = 0;
    let mut starting_station = 0;

    for i in 0..n {
        total_tank += gas[i] - cost[i];
        current_tank += gas[i] - cost[i];
        if current_tank < 0 {
            starting_station = i + 1;
            current_tank = 0;
        }
    }

    if total_tank < 0 {
        -1
    } else {
        starting_station as i32
    }
}
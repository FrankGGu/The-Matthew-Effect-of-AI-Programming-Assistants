pub fn can_complete_circuit(gas: Vec<i32>, cost: Vec<i32>) -> i32 {
    let n = gas.len();
    let mut total_gas = 0;
    let mut total_cost = 0;
    let mut current_gas = 0;
    let mut starting_station = 0;

    for i in 0..n {
        total_gas += gas[i];
        total_cost += cost[i];
        current_gas += gas[i] - cost[i];

        if current_gas < 0 {
            starting_station = i + 1;
            current_gas = 0;
        }
    }

    if total_gas < total_cost {
        return -1;
    }
    starting_station as i32
}
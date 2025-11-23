impl Solution {
    pub fn can_complete_circuit(gas: Vec<i32>, cost: Vec<i32>) -> i32 {
        let n = gas.len();
        let mut total_gas_left: i32 = 0;
        let mut current_gas_left: i32 = 0;
        let mut start_station: i32 = 0;

        for i in 0..n {
            total_gas_left += gas[i] - cost[i];
            current_gas_left += gas[i] - cost[i];

            if current_gas_left < 0 {
                current_gas_left = 0;
                start_station = (i + 1) as i32;
            }
        }

        if total_gas_left < 0 {
            -1
        } else {
            start_station
        }
    }
}
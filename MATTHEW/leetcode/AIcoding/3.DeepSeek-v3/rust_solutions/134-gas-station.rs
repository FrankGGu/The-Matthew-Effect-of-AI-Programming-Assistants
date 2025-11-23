impl Solution {
    pub fn can_complete_circuit(gas: Vec<i32>, cost: Vec<i32>) -> i32 {
        let mut total = 0;
        let mut current = 0;
        let mut start = 0;

        for i in 0..gas.len() {
            total += gas[i] - cost[i];
            current += gas[i] - cost[i];

            if current < 0 {
                start = i + 1;
                current = 0;
            }
        }

        if total >= 0 {
            start as i32
        } else {
            -1
        }
    }
}
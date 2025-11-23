int canCompleteCircuit(int* gas, int gasSize, int* cost, int costSize) {
    int total_gas_diff = 0;
    int current_tank = 0;
    int start_node = 0;

    for (int i = 0; i < gasSize; i++) {
        total_gas_diff += gas[i] - cost[i];
        current_tank += gas[i] - cost[i];

        if (current_tank < 0) {
            start_node = i + 1;
            current_tank = 0;
        }
    }

    if (total_gas_diff < 0) {
        return -1;
    } else {
        return start_node;
    }
}
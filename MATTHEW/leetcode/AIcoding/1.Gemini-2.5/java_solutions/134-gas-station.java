class Solution {
    public int canCompleteCircuit(int[] gas, int[] cost) {
        int totalGas = 0;
        int currentTank = 0;
        int startStation = 0;

        for (int i = 0; i < gas.length; i++) {
            int diff = gas[i] - cost[i];
            totalGas += diff;
            currentTank += diff;

            // If current tank goes negative, it means we cannot reach station i+1 from startStation.
            // So, we reset startStation to i+1 and clear the current tank.
            if (currentTank < 0) {
                startStation = i + 1;
                currentTank = 0;
            }
        }

        // If totalGas is negative, it's impossible to complete the circuit.
        // Otherwise, the startStation found is the unique solution.
        if (totalGas < 0) {
            return -1;
        } else {
            return startStation;
        }
    }
}
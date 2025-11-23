class Solution {
    public int minOperationsMaxProfit(int[] customers, int boardingCost, int runningCost) {
        int n = customers.length;
        int maxProfit = 0;
        int totalProfit = 0;
        int totalRunningCost = 0;
        int maxOperations = 0;
        int waitingCustomers = 0;

        for (int i = 0; i < n || waitingCustomers > 0; i++) {
            if (i < n) {
                waitingCustomers += customers[i];
            }
            int currentOperations = Math.min(waitingCustomers, 4);
            waitingCustomers -= currentOperations;
            totalProfit += currentOperations * boardingCost;
            totalRunningCost += runningCost;

            if (totalProfit - totalRunningCost > maxProfit) {
                maxProfit = totalProfit - totalRunningCost;
                maxOperations = i + 1;
            }
        }

        return maxProfit > 0 ? maxOperations : -1;
    }
}
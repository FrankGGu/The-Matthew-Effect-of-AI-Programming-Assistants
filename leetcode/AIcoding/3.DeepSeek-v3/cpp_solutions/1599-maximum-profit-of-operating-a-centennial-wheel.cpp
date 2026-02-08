class Solution {
public:
    int minOperationsMaxProfit(vector<int>& customers, int boardingCost, int runningCost) {
        int maxProfit = 0;
        int minOperations = -1;
        int currentProfit = 0;
        int waiting = 0;
        int rotations = 0;
        int totalCustomers = 0;

        for (int i = 0; i < customers.size() || waiting > 0; ++i) {
            if (i < customers.size()) {
                waiting += customers[i];
            }
            int boarding = min(4, waiting);
            waiting -= boarding;
            totalCustomers += boarding;
            rotations++;

            currentProfit = totalCustomers * boardingCost - rotations * runningCost;
            if (currentProfit > maxProfit) {
                maxProfit = currentProfit;
                minOperations = rotations;
            }
        }

        return maxProfit > 0 ? minOperations : -1;
    }
};
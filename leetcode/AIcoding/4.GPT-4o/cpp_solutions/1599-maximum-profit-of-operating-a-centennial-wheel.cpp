class Solution {
public:
    int minOperationsMaxProfit(vector<int>& A, int B) {
        int n = A.size();
        int maxProfit = 0, currentProfit = 0, operations = 0;
        int totalOperations = 0, maxOperations = -1;

        for (int i = 0; i < n; i++) {
            if (A[i] > 0) {
                currentProfit += A[i];
                operations++;
            }
            totalOperations++;

            if (operations > B) {
                while (operations > B) {
                    currentProfit -= A[i - operations + 1];
                    operations--;
                }
            }

            if (currentProfit > maxProfit) {
                maxProfit = currentProfit;
                maxOperations = totalOperations;
            }
        }

        return maxOperations == -1 ? -1 : maxOperations;
    }
};
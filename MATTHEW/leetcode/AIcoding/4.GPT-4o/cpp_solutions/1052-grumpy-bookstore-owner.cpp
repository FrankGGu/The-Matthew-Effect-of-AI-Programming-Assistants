class Solution {
public:
    int maxSatisfied(vector<int>& customers, vector<int>& grumpy, int X) {
        int totalSatisfied = 0, maxAdditional = 0, currentAdditional = 0;
        int n = customers.size();

        for (int i = 0; i < n; i++) {
            if (grumpy[i] == 0) {
                totalSatisfied += customers[i];
            }
        }

        for (int i = 0; i < n; i++) {
            if (grumpy[i] == 1) {
                currentAdditional += customers[i];
            }
            if (i >= X && grumpy[i - X] == 1) {
                currentAdditional -= customers[i - X];
            }
            if (i >= X - 1) {
                maxAdditional = max(maxAdditional, currentAdditional);
            }
        }

        return totalSatisfied + maxAdditional;
    }
};
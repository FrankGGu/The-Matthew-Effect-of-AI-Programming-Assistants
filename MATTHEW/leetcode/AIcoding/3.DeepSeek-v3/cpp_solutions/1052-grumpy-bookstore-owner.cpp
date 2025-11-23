class Solution {
public:
    int maxSatisfied(vector<int>& customers, vector<int>& grumpy, int minutes) {
        int n = customers.size();
        int satisfied = 0;
        for (int i = 0; i < n; ++i) {
            if (grumpy[i] == 0) {
                satisfied += customers[i];
            }
        }

        int max_increase = 0;
        int current_increase = 0;
        for (int i = 0; i < minutes; ++i) {
            if (grumpy[i] == 1) {
                current_increase += customers[i];
            }
        }
        max_increase = current_increase;

        for (int i = minutes; i < n; ++i) {
            if (grumpy[i - minutes] == 1) {
                current_increase -= customers[i - minutes];
            }
            if (grumpy[i] == 1) {
                current_increase += customers[i];
            }
            max_increase = max(max_increase, current_increase);
        }

        return satisfied + max_increase;
    }
};
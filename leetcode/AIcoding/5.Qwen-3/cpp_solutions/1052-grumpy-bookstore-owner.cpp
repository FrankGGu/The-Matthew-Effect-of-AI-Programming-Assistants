#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int maxSatisfied(vector<int>& customers, vector<int>& grumpy, int X) {
        int n = customers.size();
        int satisfied = 0;
        for (int i = 0; i < n; ++i) {
            if (grumpy[i] == 0) {
                satisfied += customers[i];
            }
        }

        int maxAdd = 0;
        int add = 0;
        for (int i = 0; i < X; ++i) {
            if (grumpy[i] == 1) {
                add += customers[i];
            }
        }
        maxAdd = add;

        for (int i = X; i < n; ++i) {
            if (grumpy[i] == 1) {
                add += customers[i];
            }
            if (grumpy[i - X] == 1) {
                add -= customers[i - X];
            }
            maxAdd = max(maxAdd, add);
        }

        return satisfied + maxAdd;
    }
};
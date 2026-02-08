#include <vector>
#include <algorithm>

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

        int max_extra = 0;
        int current_extra = 0;
        for (int i = 0; i < n; ++i) {
            if (grumpy[i] == 1) {
                current_extra += customers[i];
            }
            if (i >= X) {
                if (grumpy[i - X] == 1) {
                    current_extra -= customers[i - X];
                }
            }
            max_extra = max(max_extra, current_extra);
        }

        return satisfied + max_extra;
    }
};
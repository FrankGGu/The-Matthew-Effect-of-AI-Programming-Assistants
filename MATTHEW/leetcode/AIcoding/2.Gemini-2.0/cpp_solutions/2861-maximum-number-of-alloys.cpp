#include <vector>

using namespace std;

class Solution {
public:
    int maxNumberOfAlloys(int n, int k, int budget, vector<vector<int>>& composition, vector<int>& stock, vector<int>& cost) {
        int low = 0, high = 2e9;
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            bool possible = false;

            for (int i = 0; i < k; ++i) {
                long long totalCost = 0;
                for (int j = 0; j < n; ++j) {
                    long long need = (long long)composition[i][j] * mid;
                    if (need > stock[j]) {
                        totalCost += (need - stock[j]) * cost[j];
                    }
                }
                if (totalCost <= budget) {
                    possible = true;
                    break;
                }
            }

            if (possible) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return ans;
    }
};
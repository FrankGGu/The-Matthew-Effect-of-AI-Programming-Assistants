#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxNumberOfAlloys(int n, int k, int budget, vector<vector<int>>& composition, vector<int>& stock, vector<int>& cost) {
        int ans = 0;
        for (int i = 0; i < k; ++i) {
            int low = 0, high = 2000000000;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                long long totalCost = 0;
                bool possible = true;
                for (int j = 0; j < n; ++j) {
                    long long needed = (long long)composition[i][j] * mid;
                    if (needed > stock[j]) {
                        totalCost += (needed - stock[j]) * cost[j];
                    }
                }
                if (totalCost <= budget) {
                    ans = max(ans, mid);
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
        }
        return ans;
    }
};
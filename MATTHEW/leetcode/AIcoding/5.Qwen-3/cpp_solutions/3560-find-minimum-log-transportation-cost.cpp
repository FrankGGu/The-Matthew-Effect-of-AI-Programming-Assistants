#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCostToConvert(int n, vector<int>& cost) {
        sort(cost.begin(), cost.end());
        int total = 0;
        for (int i = 0; i < n - 1; ++i) {
            total += cost[i];
        }
        return total;
    }
};
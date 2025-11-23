#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCostToRearrangeFruits(vector<int>& fruits, int k) {
        int n = fruits.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + fruits[i];
        }

        int result = INT_MAX;
        for (int i = 0; i <= n - k; ++i) {
            int total = prefix[i + k] - prefix[i];
            int avg = total / k;
            int cost = 0;
            for (int j = i; j < i + k; ++j) {
                cost += abs(fruits[j] - avg);
            }
            result = min(result, cost);
        }

        return result;
    }
};
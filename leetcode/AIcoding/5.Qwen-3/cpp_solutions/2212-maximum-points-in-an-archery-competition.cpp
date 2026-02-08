#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> maximumPoints(int n, vector<vector<int>>& queries) {
        vector<int> result;
        vector<int> prefix(n, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i] = queries[i][0];
        }
        sort(prefix.begin(), prefix.end());
        for (int i = 1; i < n; ++i) {
            prefix[i] += prefix[i - 1];
        }
        for (int i = 0; i < n; ++i) {
            int total = 0;
            for (int j = 0; j < n; ++j) {
                if (prefix[j] <= queries[i][1]) {
                    total += queries[i][2];
                }
            }
            result.push_back(total);
        }
        return result;
    }
};
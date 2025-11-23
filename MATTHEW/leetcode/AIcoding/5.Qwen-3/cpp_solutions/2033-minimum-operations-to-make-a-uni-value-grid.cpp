#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperationsToMakeUniValueGrid(vector<vector<int>>& grid) {
        vector<int> values;
        for (const auto& row : grid) {
            for (int val : row) {
                values.push_back(val);
            }
        }

        sort(values.begin(), values.end());

        int n = values.size();
        int median = values[n / 2];

        int operations = 0;
        for (int val : values) {
            operations += abs(val - median);
        }

        return operations;
    }
};
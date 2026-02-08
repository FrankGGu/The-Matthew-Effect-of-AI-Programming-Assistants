#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumTotalImportance(vector<int>& n, vector<vector<int>>& roads) {
        vector<int> degree(n.size(), 0);
        for (const auto& road : roads) {
            degree[road[0]]++;
            degree[road[1]]++;
        }
        sort(degree.begin(), degree.end());
        int total = 0;
        for (int i = 0; i < n.size(); ++i) {
            total += degree[i] * (i + 1);
        }
        return total;
    }
};